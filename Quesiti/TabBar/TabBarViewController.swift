//
//  TabBarViewController.swift
//  Quesiti
//
//  Created by Даниил Ярмоленко on 29.10.2021.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        configureTabBarItems()
    }

    private func configureTabBarItems() {
        let homePageVC = HomePageViewController()
        let homePagePresenter = HomePagePresenter(view: homePageVC)
        homePageVC.presenter = homePagePresenter
        homePageVC.tabBarItem = UITabBarItem(title: "Home Page", image: UIImage(systemName: "house.fill"), tag: 0)

        let searchVC = SearchViewController()
        let searchPresenter = SearchPresenter(view: searchVC)
        searchVC.presenter = searchPresenter
        searchVC.tabBarItem = UITabBarItem(title: "Search Question", image: UIImage(systemName: "magnifyingglass.circle"), tag: 1)
        
        let addQuestionVC = AddQuestionViewController()
        let addQuestionPresenter = AddQuestionPresenter(view: addQuestionVC)
        addQuestionVC.presenter = addQuestionPresenter
        addQuestionVC.tabBarItem = UITabBarItem(title: "addQuestion", image: UIImage(systemName: "plus.circle"), tag: 2)

        let mapVC = MapViewController()
        let mapPresenter = MapPresenter(view: mapVC)
        mapVC.presenter = mapPresenter
        mapVC.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), tag: 3)
        
        let profileVC = ProfileViewController()
        let profilePresenter = ProfilePresenter(view: profileVC)
        profileVC.presenter = profilePresenter
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 4)
        
        let homePageNavigationVC = UINavigationController(rootViewController: homePageVC)
        
        let addQuestionNavigationVC = UINavigationController(rootViewController: addQuestionVC)
        
        let searchNavigationVC = UINavigationController(rootViewController: searchVC)
        
        let mapNavigationVC = UINavigationController(rootViewController: mapVC)
        
        let profileNavigationVC = UINavigationController(rootViewController: profileVC)
        setViewControllers([homePageNavigationVC,searchNavigationVC, addQuestionNavigationVC, mapNavigationVC, profileNavigationVC], animated: true)
    }
}
