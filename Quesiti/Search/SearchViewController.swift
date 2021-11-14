//
//  SearchViewController.swift
//  Quesiti
//
//  Created by Даниил Ярмоленко on 13.11.2021.
//

import UIKit

protocol SearchViewProtocol: AnyObject {
    
}

class SearchViewController: UIViewController {
    
    var presenter: SearchViewPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        self.view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive=true
        label.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive=true
        // Do any additional setup after loading the view.
    }

    let label:UILabel = {
        let label = UILabel()
        label.text = "Здесь будет страница поиска вопроса по критериям"
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
