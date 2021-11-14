//
//  HomePageViewController.swift
//  Quesiti
//
//  Created by Даниил Ярмоленко on 29.10.2021.
//

import UIKit

let question = [[1: "avatar", 2: "Alex", 3: "Какая погода", 4: "11:00 23.11", 5: "300"], [1: "Question", 2: "Mark", 3: "Который час", 4: "03:00 10.11", 5: "53"], [1: "MapsHome", 2: "Artur", 3: "Что по мемам", 4: "19:00 5.11", 5: "18"], [1: "avatar", 2: "Alex", 3: "Какая погода", 4: "11:00 23.11", 5: "3"], [1: "Question", 2: "Mark", 3: "Который час", 4: "03:00 10.11", 5: "53"], [1: "MapsHome", 2: "Artur", 3: "Что по мемам", 4: "19:00 5.11", 5: "18"], [1: "avatar", 2: "Alex", 3: "Какая погода", 4: "11:00 23.11", 5: "3"], [1: "Question", 2: "Mark", 3: "Который час", 4: "03:00 10.11", 5: "53"], [1: "MapsHome", 2: "Artur", 3: "Что по мемам", 4: "19:00 5.11", 5: "18"]]

protocol HomePageViewProtocol: AnyObject {
    
}

class HomePageViewController: UIViewController {
    
    var presenter: HomePageViewPresenter!
    
    lazy var tableView: UITableView = {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var homePageView: HomePageView = {
        let homePageView = HomePageView()
        
        return homePageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        view.addSubview(homePageView)
        view.addSubview(tableView)
        navigationController?.navigationBar.isHidden = true
        
        setupLayoutHomePageView()
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: .tableId)
        tableView.dataSource = self
        tableView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func setupLayoutHomePageView(){
        homePageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            homePageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homePageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homePageView.topAnchor.constraint(equalTo: view.topAnchor),
            homePageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -3 * UIScreen.main.bounds.height/5),
            
            tableView.topAnchor.constraint(equalTo: homePageView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
         ])
    }
    
    @objc
        private func didPullToRefresh() {
            tableView.refreshControl?.beginRefreshing()
            tableView.refreshControl?.endRefreshing()
    }
}

extension HomePageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return question.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .tableId, for: indexPath) as? TableViewCell else {
            fatalError()
        }
        let ques = question[indexPath.row]
        
        cell.avatarView.image = UIImage(named: ques[1] ?? "")
        cell.nameLabel.text = ques[2]
        cell.questionLabel.text = ques[3]
        cell.dateLabel.text = ques[4]
        cell.countOfComsView.text = ques[5]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
    }
    
}

private extension String {
    static let tableId = "TableViewCellReuseID"
}
