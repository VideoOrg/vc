//
//  VCTabBarController.swift
//  VideoCapture
//
//  Created by admin on 16/9/5.
//  Copyright © 2016年 zhangyun. All rights reserved.
//

import UIKit

class VCTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 添加子控制器
        addChildViewControllers()
    }

    /**
     # 添加子控制器
     */
    private func addChildViewControllers(){
        addChildViewController(controller: VCHomeViewController(), title: "主页", imageName: "VCTabBar_home")
        addChildViewController(controller: VCMyViewController(), title: "我", imageName: "VCTabBar_me_boy")
       
    }
    
    private func addChildViewController(controller: UIViewController, title:String, imageName:String){
        
        controller.tabBarItem.image = UIImage(named: imageName)
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")
        controller.tabBarItem.title = title
        
        let nav = VCBaseNavigationViewController()
        nav.addChildViewController(controller)
        addChildViewController(nav)
    }
    
    
}
