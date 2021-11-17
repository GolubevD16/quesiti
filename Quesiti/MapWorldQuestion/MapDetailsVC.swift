//
//  DetailsVC.swift
//  googlMapTutuorial2
//
//  Created by Muskan on 12/17/17.
//  Copyright © 2017 akhil. All rights reserved.
//

import UIKit



class DetailsVC: UIViewController{
    
    
    var passedData = Question(title: "Какая погода ?", userID: "bjhksdf23", latitude: 24.865, longitude: 67.0011, radius: 1000, image: UIImage(named: "people1"), name: "Name")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupViews()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: .tableId)
        tableView.dataSource = self
        tableView.delegate = self
        containerTitle.layer.shadowColor = UIColor.black.cgColor
        containerTitle.layer.shadowRadius = 5
        containerTitle.layer.shadowOffset = .init(width: 0, height: 2)
        containerTitle.layer.shadowOpacity = 0.8
       
        containerTitle.backgroundColor = .white

    }
    
    
    func setupViews() {
        //        myScrollView.contentSize.height = 800
        
        view.addSubview(containerView)
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive=true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive=true
        containerView.heightAnchor.constraint(equalToConstant: 350).isActive=true
        
        containerView.addSubview(imgView)
        imgView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive=true
        imgView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive=true
        imgView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive=true
        imgView.heightAnchor.constraint(equalToConstant: 200).isActive=true
        imgView.image = passedData.image
        
        containerView.addSubview(containerTitle)
        containerTitle.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 15).isActive=true
        containerTitle.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: 10).isActive=true
        containerTitle.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -15).isActive=true
        containerTitle.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive=true
        
        containerTitle.addSubview(lblTitle)
        lblTitle.leftAnchor.constraint(equalTo: containerTitle.leftAnchor ).isActive=true
        lblTitle.rightAnchor.constraint(equalTo: containerTitle.rightAnchor).isActive=true
        lblTitle.topAnchor.constraint(equalTo: containerTitle.topAnchor).isActive=true
        lblTitle.bottomAnchor.constraint(equalTo: containerTitle.bottomAnchor).isActive=true
        lblTitle.text = passedData.title
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: containerTitle.bottomAnchor, constant: 10).isActive=true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive=true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive=true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive=true
        
        view.addSubview(containerButton)
        containerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        containerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -74).isActive=true
        containerButton.widthAnchor.constraint(equalToConstant: 72).isActive=true
        containerButton.heightAnchor.constraint(equalTo: containerButton.widthAnchor).isActive=true
        
        containerButton.addSubview(btnAnswerQuestion)
        btnAnswerQuestion.topAnchor.constraint(equalTo: containerButton.topAnchor).isActive=true
        btnAnswerQuestion.leftAnchor.constraint(equalTo: containerButton.leftAnchor).isActive=true
        btnAnswerQuestion.rightAnchor.constraint(equalTo: containerButton.rightAnchor).isActive=true
        btnAnswerQuestion.bottomAnchor.constraint(equalTo: containerButton.bottomAnchor).isActive=true
        
        containerButton.addSubview(titleButton)
        titleButton.centerYAnchor.constraint(equalTo: containerButton.centerYAnchor).isActive=true
        titleButton.leftAnchor.constraint(equalTo: containerButton.leftAnchor).isActive=true
        titleButton.rightAnchor.constraint(equalTo: containerButton.rightAnchor).isActive=true
        
    }
    
    //    let myScrollView: UIScrollView = {
    //        let scrollView = UIScrollView()
    //        scrollView.translatesAutoresizingMaskIntoConstraints=false
    //        scrollView.showsVerticalScrollIndicator=false
    //        scrollView.showsHorizontalScrollIndicator=false
    //        return scrollView
    //    }()
    
    let containerView: UIView = {
        let v=UIView()
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    lazy var containerTitle: UIView = {
        containerTitle = UIView()
//        containerTitle.layer.shadowColor = UIColor.black.cgColor
//        containerTitle.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
//        containerTitle.layer.shadowRadius = 2.0
//        containerTitle.layer.shadowOpacity = 0.5
        containerTitle.layer.cornerRadius = 20

        
        containerShadow.layer.masksToBounds = true
        
        containerTitle.translatesAutoresizingMaskIntoConstraints=false
        return containerTitle
    }()
    
    lazy var containerShadow: UIView = {
        containerShadow = UIView()
//        containerTitle.layer.cornerRadius = 20
        var rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: containerShadow.frame.width, height: containerShadow.frame.height))
        var path = UIBezierPath(rect: rect);
        containerShadow.layer.shadowPath = path.cgPath
        containerShadow.layer.masksToBounds = false
        containerShadow.translatesAutoresizingMaskIntoConstraints=false
        return containerShadow
    }()
    
    let imgView: UIImageView = {
        let v=UIImageView()
        v.image = UIImage(named: "people1")
        v.contentMode = .scaleAspectFill
        v.clipsToBounds=true
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    let lblTitle: UILabel = {
        let lbl=UILabel()
        lbl.text = "Name"
        lbl.font=UIFont.systemFont(ofSize: 28)
        lbl.textColor = UIColor.black
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let lblPrice: UILabel = {
        let lbl=UILabel()
        lbl.text = "Price"
        lbl.font=UIFont.boldSystemFont(ofSize: 24)
        lbl.textColor = UIColor(white: 0.5, alpha: 1)
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let lblDescription: UILabel = {
        let lbl=UILabel()
        lbl.text = "Description"
        lbl.numberOfLines = 0
        lbl.font=UIFont.systemFont(ofSize: 20)
        lbl.textColor = UIColor.gray
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    let btnAnswerQuestion: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        //        let config = UIImage.SymbolConfiguration(textStyle: .)
        let config = UIImage.SymbolConfiguration(textStyle: .title1)
        btn.clipsToBounds=true
        btn.tintColor = UIColor.white
        let squarePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 72, height: 72), byRoundingCorners:.allCorners, cornerRadii: CGSize(width: 20.0, height: 20.0))
        let squareLayer = CAShapeLayer()
        //        squarePath.move(to: CGPoint(x: 39, y: 0))
        //
        //        squarePath.addLine(to: CGPoint(x: 79, y: 39))
        //        squarePath.addLine(to: CGPoint(x: 39, y: 79))
        //        squarePath.addLine(to: CGPoint(x: 0, y: 39))
        //        squarePath.addLine(to: CGPoint(x: 39, y: 0))
        //        squarePath.addLine(to: CGPoint(x: 100, y: 0))
        //        squarePath.close()
        squareLayer.path = squarePath.cgPath
        //        squareLayer.transform = CATransform3DMakeRotation(CGFloat(45*Double.pi/180), 0, -49, 1)
        squareLayer.fillColor = ThemeColors.mainColor.cgColor
        btn.layer.addSublayer(squareLayer)
        btn.clipsToBounds=true
        
        btn.addTarget(self, action: #selector(btnAnswer(_:)), for: .touchUpInside)
        btn.transform = CGAffineTransform(rotationAngle: CGFloat.pi/4)
        btn.translatesAutoresizingMaskIntoConstraints=false
        return btn
    }()
    let titleButton: UILabel = {
        let lbl=UILabel()
        lbl.text = "Answer ?"
        lbl.numberOfLines = 0
        lbl.font=UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .center
        lbl.textColor = UIColor.white
        lbl.translatesAutoresizingMaskIntoConstraints=false
        return lbl
    }()
    
    lazy var tableView: UITableView = {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let containerButton: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()
    
    @objc func btnAnswer(_ sender: Any){
        navigationController?.popViewController(animated: true)
    }
    @objc private func didPullToRefresh() {
        tableView.refreshControl?.beginRefreshing()
        tableView.refreshControl?.endRefreshing()
    }
}

extension DetailsVC: UITableViewDataSource, UITableViewDelegate {
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
        return 90
    }
}

private extension String {
    static let tableId = "TableViewCellReuseID"
}

