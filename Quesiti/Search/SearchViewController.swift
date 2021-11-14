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
        self.view.addSubview(btnAddQuestion)
        btnAddQuestion.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65).isActive=true
        btnAddQuestion.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        btnAddQuestion.widthAnchor.constraint(equalToConstant: 50).isActive=true
        btnAddQuestion.heightAnchor.constraint(equalTo: btnAddQuestion.widthAnchor).isActive=true
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
    
    lazy var btnAddQuestion: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        let config = UIImage.SymbolConfiguration(textStyle: .title1)
        btn.backgroundColor = UIColor.green
        btn.setImage(UIImage(systemName: "plus.circle", withConfiguration: config), for: .normal)
        btn.layer.cornerRadius = 25
        btn.clipsToBounds=true
        btn.tintColor = UIColor.yellow
        btn.imageView?.sizeToFit()
        btn.addTarget(self, action: #selector(btnAddQuestionAction), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()
    
    @objc func btnAddQuestionAction() {
        let addQuuestion: AddQuestionViewController = AddQuestionViewController()
        addQuuestion.modalPresentationStyle = .fullScreen
        self.present(addQuuestion, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
