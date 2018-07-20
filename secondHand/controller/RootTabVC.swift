//
//  RootTabVC.swift
//  secondHand
//
//  Created by ZechengLi on 7/20/18.
//  Copyright © 2018 ZechengLi. All rights reserved.
//

import UIKit

class RootTabVC: UITabBarController {
    var controllers:  [UINavigationController]!
    override func viewDidLoad() {
        super.viewDidLoad()
        controllers = [UINavigationController]()
        setupHomeNavigationVC()
        setupGroupNavigationVC()
        setupChatNavigationVC()
        setupUserNAvigationVC()
        
        self.tabBarController?.viewControllers = controllers
    }

    //MARK: - set up home navigation VC
    private func setupHomeNavigationVC() {
        let homeVC = HomeViewController()
        let homeNavagitionVC = UINavigationController(rootViewController: homeVC)
        homeNavagitionVC.tabBarItem = UITabBarItem(title: "首页", image: UIImage(named: "home.png"), tag: 0)
        controllers.append(homeNavagitionVC)
        
    }
    
    //MARK: - set up group navigation VC
    private func setupGroupNavigationVC() {
        let groupVC = GroupVC()
        let groupNavigationVC = UINavigationController(rootViewController: groupVC)
        groupNavigationVC.tabBarItem = UITabBarItem(title: "圈子", image: UIImage(named: "group.png"), tag: 1)
        controllers.append(groupNavigationVC)
    }
    
    //MARK: - set up chat navigation VC
    private func setupChatNavigationVC() {
        let chatVC = ChatVC()
        let chatNavigationVC = UINavigationController(rootViewController: chatVC)
        chatNavigationVC.tabBarItem = UITabBarItem(title: "消息", image: UIImage(named: "message.png"), tag: 2)
        controllers.append(chatNavigationVC)
    }
    
    //MARK: - set up user navigation VC
    private func setupUserNAvigationVC() {
        let userVC = UserVC()
        let userNavigationVC = UINavigationController(rootViewController: userVC)
        userNavigationVC.tabBarItem = UITabBarItem(title: "我的", image: UIImage(named: "user.png"), tag: 3)
        controllers.append(userNavigationVC)
    }
    

    
}
