//
//  HomePageViewController.swift
//  Quesiti
//
//  Created by Даниил Ярмоленко on 29.10.2021.
//

import UIKit
import Firebase
import CoreLocation


protocol HomePageViewProtocol: AnyObject {
    
}

class HomePageViewController: UIViewController {
    
    var locationManager = CLLocationManager()
    var questionsOfUser: [QuestionModel] = []
    var presenter: HomePageViewPresenter!
    var user: User?{
        didSet{
            homePageView.nameLabel.text = user?.name
            homePageView.cityLabel.text = user?.city
            if user?.aboutYou != ""{
                homePageView.aboutYouText.text = user?.aboutYou
            }
            guard let uid = user?.uid else {return}
            if let url = user?.avatarURL{
                if url != "" {
                    Storage.storage().loadUserProfileImage(url: url, completion: {(imageData) in
                        let image = UIImage(data: imageData)
                        self.homePageView.avatarView.image = image
                    })
                }
            }
            Database.database().checkCountOfSubs(withUID: uid) { subs in
                self.homePageView.folCount.text = subs
            }
            
            Database.database().checkCountOfFolls(withUID: uid) { folls in
                self.homePageView.subsCount.text = folls
            }
            
            fetchQuestionsOfUsers(uid: uid)
        }
    }
    
    lazy var tableView: UITableView = {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var btnAddQuestion: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        let config = UIImage.SymbolConfiguration(textStyle: .title1)
        btn.backgroundColor = ThemeColors.mainColor
        btn.setImage(UIImage(systemName: "plus.circle", withConfiguration: config), for: .normal)
        btn.layer.cornerRadius = 25
        btn.clipsToBounds=true
        btn.tintColor = UIColor.white
        btn.imageView?.sizeToFit()
        btn.addTarget(self, action: #selector(btnAddQuestionAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()
    
    lazy var homePageView: HomePageView = {
        let homePageView = HomePageView()
        homePageView.nameLabel.text = user?.name
        homePageView.cityLabel.text = user?.city
        
        return homePageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //homePageView.answerQuestionsLine.backgroundColor = .systemPink
        navigationController?.setNavigationBarHidden(false, animated: true)
        view.addSubview(homePageView)
        view.addSubview(tableView)
        view.addSubview(btnAddQuestion)
        self.homePageView.aboutYouText.isEditable = false
        setupLayoutHomePageView()
        setupHomePageView()
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: .tableId)
        tableView.dataSource = self
        tableView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homePageView.myQuestionsButton.setTitleColor(.black, for: .normal)
        homePageView.myQuestionsLine.backgroundColor = .blue
        homePageView.folowingQuestionsButton.setTitleColor(.systemGray4, for: .normal)
        homePageView.folowingQuestionsLine.backgroundColor = .white
        homePageView.answerQuestionsButton.setTitleColor(.systemGray4, for: .normal)
        homePageView.answerQuestionsLine.backgroundColor = .white
        guard let id = user?.uid else {print("poteryvsya");return}
        reloadUser(uid: id)
        fetchQuestionsOfUsers(uid: id)
        if let url = user?.avatarURL{
            if url != "" {
                Storage.storage().loadUserProfileImage(url: url, completion: {(imageData) in
                    let image = UIImage(data: imageData)
                    self.homePageView.avatarView.image = image
                })
            }
        }
    }
    
    func measure(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double{  // generally used geo measurement function
        let R = 6378.137; // Radius of earth in M
        let pi = 3.1415926
        let dLat = abs(lat2 * pi/180 - lat1 * pi/180)
        let latPlus = lat2 * pi/180 + lat1 * pi/180
        let dLon = abs(lon2 * pi/180 - lon1 * pi/180)
        let conv = sqrt(sin(dLat/2)*sin(dLat/2)+(1-sin(dLat/2)*sin(dLat/2)-sin(latPlus/2)*sin(latPlus/2))*sin(dLon/2)*sin(dLon/2))
        let rez = 2*R*asin(conv)*1000
        return rez // meters
    }
    
    private func setupHomePageView(){
        self.homePageView.folowingQuestionsButton.addTarget(self, action: #selector(clickFolButton), for: .touchUpInside)
        self.homePageView.myQuestionsButton.addTarget(self, action: #selector(clickMyQuesButton), for: .touchUpInside)
        self.homePageView.answerQuestionsButton.addTarget(self, action: #selector(clickMyAnswersButton), for: .touchUpInside)
    }
    
    @objc
    private func clickFolButton(){
        
        Database.database().fetchFolQuestion(withUID: user?.uid ?? "") { questions in
            self.questionsOfUser = questions
            self.tableView.reloadData()
        }
    }
    
    @objc
    private func clickMyQuesButton(){
        fetchQuestionsOfUsers(uid: user?.uid ?? "")
    }
    
    @objc
    private func clickMyAnswersButton(){
        Database.database().fetchMyAnswers(withUID: user?.uid ?? "") { questions in
            self.questionsOfUser = questions
            self.tableView.reloadData()
        }
    }
    
    private func reloadUser(uid: String){
        Database.database().fetchUser(withUID: uid) { (user) in
            self.homePageView.nameLabel.text = user.name
            self.homePageView.cityLabel.text = user.city
            self.user = user
        }
        
        Database.database().checkCountOfSubs(withUID: uid) { subs in
            self.homePageView.folCount.text = subs
        }
        
        Database.database().checkCountOfFolls(withUID: uid) { folls in
            self.homePageView.subsCount.text = folls
        }
    }
    
    private func fetchQuestionsOfUsers(uid: String){
        Database.database().fetchAllPostsOfUser(withUID: uid) { questions, count in
            self.questionsOfUser = questions
            self.tableView.reloadData()
            self.homePageView.questionsCount.text = String(questions.count)
        } withCancel: { _ in
            return
        }
    }
    
    private func setupLayoutHomePageView(){
        homePageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homePageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homePageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homePageView.topAnchor.constraint(equalTo: view.topAnchor, constant: -50),
            homePageView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            
            tableView.topAnchor.constraint(equalTo: homePageView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            btnAddQuestion.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65),
            btnAddQuestion.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnAddQuestion.widthAnchor.constraint(equalToConstant: 50),
            btnAddQuestion.heightAnchor.constraint(equalTo: btnAddQuestion.widthAnchor),
         ])
    }
    
    @objc
        private func didPullToRefresh() {
            tableView.refreshControl?.beginRefreshing()
            tableView.refreshControl?.endRefreshing()
    }
    
    @objc func btnAddQuestionAction() {
        let addQuuestion: AddQuestionViewController = AddQuestionViewController()
        addQuuestion.modalPresentationStyle = .fullScreen
        self.present(addQuuestion, animated: true, completion: nil)
    }
}

extension HomePageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionsOfUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .tableId, for: indexPath) as? TableViewCell else {
            fatalError()
        }
        let ques = questionsOfUser[indexPath.row]
        if ques.user.avatarURL != "" {
            Storage.storage().loadUserProfileImage(url: ques.user.avatarURL ?? "", completion: {(imageData) in
                let image = UIImage(data: imageData)
                cell.avatarView.image = image
            })
        }else{
            cell.avatarView.image = UIImage(named: "avatar")
        }
        //cell.avatarView.image = UIImage(named: ques.user.avatarURL)
        cell.nameLabel.text = ques.user.name
        cell.questionLabel.text = ques.titleQuestion
        cell.dateLabel.text = ques.creationDate.timeAgoDisplay()
        cell.countOfComsView.text = "\(ques.answerCount)"
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ques = questionsOfUser[indexPath.row]
        let distance = measure(lat1: ques.latitude, lon1: ques.longitude, lat2: locationManager.location?.coordinate.latitude ?? 0.0, lon2: locationManager.location?.coordinate.longitude ?? 0.0)
        let rest = DetailsVC()
        if(distance < ques.radius.doubleValue){
            rest.permissionAsq = true
        } else{
            rest.permissionAsq = false
        }
        rest.keyID = ques.user.uid
        rest.keyQuestion = ques.id
        rest.distance = distance
        rest.radius = ques.radius
        rest.countAnswer = ques.answerCount
        rest.nameUser = ques.user.name
        rest.time = ques.creationDate

        rest.titleQuestion = ques.titleQuestion
        rest.textQuestion = ques.textQuestion
        self.navigationController?.pushViewController(rest, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120
    }
}
 

private extension String {
    static let tableId = "TableViewCellReuseID"
}
