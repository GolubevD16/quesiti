//
//  SearchViewController.swift
//  Quesiti
//
//  Created by Даниил Ярмоленко on 13.11.2021.
//

import UIKit

protocol SearchViewProtocol: AnyObject {
    
}

let questions = [[1: "people1", 2: "Alex", 3: "Какая погода", 4: "11:00 23.11", 5: "300"], [1: "people2", 2: "Mark", 3: "Который час", 4: "03:00 10.11", 5: "53"], [1: "people3", 2: "Artur", 3: "Что по мемам", 4: "19:00 5.11", 5: "18"], [1: "avatar", 2: "Alex", 3: "Какая погода", 4: "11:00 23.11", 5: "3"], [1: "people3", 2: "Mark", 3: "Который час", 4: "03:00 10.11", 5: "53"], [1: "people1", 2: "Artur", 3: "Что по мемам", 4: "19:00 5.11", 5: "18"], [1: "avatar", 2: "Alex", 3: "Какая погода", 4: "11:00 23.11", 5: "3"], [1: "people3", 2: "Mark", 3: "Который час", 4: "03:00 10.11", 5: "53"], [1: "people1", 2: "Artur", 3: "Что по мемам", 4: "19:00 5.11", 5: "18"]]

let users = [[1: "people1", 2: "Alex", 3: "Moscow"], [1: "people2", 2: "Mark", 3: "New York"], [1: "people1", 2: "Artur", 3: "Penza"], [1: "people3", 2: "Alex", 3: "Moscow"], [1: "people1", 2: "Mark", 3: "New York"], [1: "people3", 2: "Artur", 3: "Penza"], [1: "avatar", 2: "Alex", 3: "Moscow"], [1: "people1", 2: "Mark", 3: "New York"], [1: "people3", 2: "Artur", 3: "Penza"], [1: "avatar", 2: "Alex", 3: "Moscow"], [1: "people2", 2: "Mark", 3: "New York"], [1: "people1", 2: "Artur", 3: "Penza"]]

class SearchViewController: UIViewController {
    
    var presenter: SearchViewPresenter!
    
    lazy var searchView: SearchView = {
        searchView = SearchView()
        searchView.translatesAutoresizingMaskIntoConstraints = false
        
        return searchView
    }()
    
    let btnAddQuestion: UIButton = {
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
    
    lazy var tableView: UITableView = {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var collectionView: UICollectionView = {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        //collectionView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        view.addSubview(searchView)
        view.addSubview(tableView)
        view.addSubview(btnAddQuestion)
        setupProfileView()
        setupLayoutWithTable()
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: .tableId)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: .colId)
        tableView.dataSource = self
        tableView.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupProfileView(){
        self.searchView.peopleButton.addTarget(self, action: #selector(clickPeopleButton(_:)), for: .touchUpInside)
        self.searchView.questionButton.addTarget(self, action: #selector(clickQuestionButton(_:)), for: .touchUpInside)
    }

    private func setupLayoutWithTable(){
        NSLayoutConstraint.activate([
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchView.heightAnchor.constraint(equalToConstant: 160),
            
            btnAddQuestion.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65),
            btnAddQuestion.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnAddQuestion.widthAnchor.constraint(equalToConstant: 50),
            btnAddQuestion.heightAnchor.constraint(equalTo: btnAddQuestion.widthAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupLayoutWithCollection(){
        NSLayoutConstraint.activate([
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchView.heightAnchor.constraint(equalToConstant: 160),
            
            btnAddQuestion.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65),
            btnAddQuestion.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnAddQuestion.widthAnchor.constraint(equalToConstant: 50),
            btnAddQuestion.heightAnchor.constraint(equalTo: btnAddQuestion.widthAnchor),
            
            collectionView.topAnchor.constraint(equalTo: searchView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc func clickPeopleButton(_: Any){
        tableView.removeFromSuperview()
        view.addSubview(collectionView)
        setupLayoutWithCollection()
    }
    
    @objc func clickQuestionButton(_: Any){
        collectionView.removeFromSuperview()
        view.addSubview(tableView)
        setupLayoutWithTable()
    }
    
    @objc func btnAddQuestionAction() {
        let addQuuestion: AddQuestionViewController = AddQuestionViewController()
        addQuuestion.modalPresentationStyle = .fullScreen
        self.present(addQuuestion, animated: true, completion: nil)
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .tableId, for: indexPath) as? TableViewCell else {
            fatalError()
        }
        let ques = questions[indexPath.row]
        
        cell.avatarView.image = UIImage(named: ques[1] ?? "")
        cell.nameLabel.text = ques[2]
        cell.questionLabel.text = ques[3]
        cell.dateLabel.text = ques[4]
        cell.countOfComsView.text = ques[5]
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rest = DetailsVC()
        self.navigationController?.pushViewController(rest, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
    }
}



private extension String {
    static let tableId = "TableViewCellReuseID"
    static let colId = "CollectionViewCellReuseID"
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: .colId, for: indexPath) as? CollectionViewCell else {
            fatalError()
        }
        let user = users[indexPath.row]
        
        cell.avatarView.image = UIImage(named: user[1] ?? "")
        cell.nameLabel.text = user[2]
        cell.cityLabel.text = user[3]
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let rest = HomePageViewController()
        self.navigationController?.pushViewController(rest, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 10, height: collectionView.frame.height/3)
    }
}

