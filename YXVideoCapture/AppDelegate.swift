//
//  AppDelegate.swift
//  YXVideoCapture
//
//  Created by admin on 16/9/18.
//  Copyright © 2016年 SYP. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKey()
        
        let user = BmobUser.current()
        

//        if ((user?.username) != nil) {
             let VC = VCTabBarController()
            // let nav = VCBaseNavigationViewController()
            // nav.addChildViewController(VC)
            
             window?.rootViewController = VC;
            
            
//
//        }else{
//             let VC = VCLoginViewContoller()
//             let nav = VCBaseNavigationViewController()
//             nav.addChildViewController(VC)
//             window?.rootViewController = nav;
//
//        }
        
                
       let appKey = "e9e2b431246dd62689c91263d52522de"
       Bmob.register(withAppKey: appKey)
        
        
        
//        let gameScore = BmobObject(className: "GameScore")
//        gameScore?.setObject("小明", forKey: "name")
//        gameScore?.setObject("13", forKey: "age")
//        gameScore?.saveInBackground { (isSuccessful, error) in
//            if isSuccessful == true {
//                print("大家伙")
//            }
//        }
        
//        
//        let bquery = BmobQuery(className: "GameScore")
//        
//        bquery?.getObjectInBackground(withId:"214e30a695", block: { (bmobObject, error) in
//            if ((error) != nil) {
//                
//            }else{
//                if (bmobObject != nil) {
//                    let nameSting:String = bmobObject?.object(forKey: "name") as! String
//                    print(nameSting)
//                }
//            }
//        })
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

