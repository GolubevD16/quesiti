//
//  HomePageViewController.swift
//  Quesiti
//
//  Created by Даниил Ярмоленко on 29.10.2021.
//

import UIKit

protocol HomePageViewProtocol: AnyObject {
    
}

class HomePageViewController: UIViewController {
    
    var presenter: HomePageViewPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        // Do any additional setup after loading the view.
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
