//
//  SignUpViewController.swift
//  Quesiti
//
//  Created by Даниил Ярмоленко on 29.10.2021.
//

import UIKit

class SignUpViewController: UIViewController, UITextViewDelegate{

    var signUpView: SignUpView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .red
        signUpView = SignUpView(self)

        // Do any additional setup after loading the view.
    }
    
    

}
