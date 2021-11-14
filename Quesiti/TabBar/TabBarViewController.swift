//
//  TabBarViewController.swift
//  Quesiti
//
//  Created by Даниил Ярмоленко on 29.10.2021.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        configureTabBarItems()
        setValue(AppTabBar(frame: tabBar.frame), forKey: "tabBar")
                view.backgroundColor = .white
//        if #available(iOS 15.0, *) {
//            let appearance = UITabBarAppearance()
//            appearance.configureWithOpaqueBackground()
//            appearance.backgroundColor = .white
//            tabBar.standardAppearance = appearance
//            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
//        }
    }

    
    private func configureTabBarItems() {
        let homePageVC = HomePageViewController()
        let homePagePresenter = HomePagePresenter(view: homePageVC)
        homePageVC.presenter = homePagePresenter
        homePageVC.tabBarItem = UITabBarItem(title: "Home Page", image: UIImage(systemName: "house.fill"), tag: 0)

        
        let searchVC = SearchViewController()
        let searchPresenter = SearchPresenter(view: searchVC)
        searchVC.presenter = searchPresenter
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass.circle"), tag: 1)
        
        
        let addQuestionVC = AddQuestionViewController()
        let addQuestionPresenter = AddQuestionPresenter(view: addQuestionVC)
        addQuestionVC.presenter = addQuestionPresenter
    
        let mapVC = MapViewController()
        let mapPresenter = MapPresenter(view: mapVC)
        mapVC.presenter = mapPresenter
        mapVC.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), tag: 2)
        
        let profileVC = ProfileViewController()
        let profilePresenter = ProfilePresenter(view: profileVC)
        profileVC.presenter = profilePresenter
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 3)
        
        let homePageNavigationVC = UINavigationController(rootViewController: homePageVC)
        
        
        let searchNavigationVC = UINavigationController(rootViewController: searchVC)
        
        let mapNavigationVC = UINavigationController(rootViewController: mapVC)
        
        let profileNavigationVC = UINavigationController(rootViewController: profileVC)
        setViewControllers([homePageNavigationVC,searchNavigationVC, mapNavigationVC, profileNavigationVC], animated: true)
        
    }
    
    @available(iOS 15.0, *)
        private func updateTabBarAppearance() {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            
            let barTintColor: UIColor = .white
            tabBarAppearance.backgroundColor = barTintColor
            
            self.tabBar.standardAppearance = tabBarAppearance
            self.tabBar.scrollEdgeAppearance = tabBarAppearance
        }
        
        @available(iOS 15.0, *)
        private func updateNavBarAppearance(navController: UINavigationController) {
            let navBarAppearance: UINavigationBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            
            let navTintColor: UIColor = .white
            navBarAppearance.backgroundColor = navTintColor
            
            navController.navigationBar.standardAppearance = navBarAppearance
            navController.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
}
