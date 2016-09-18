//
//  VCHomeViewController.swift
//  VideoCapture
//
//  Created by admin on 16/9/5.
//  Copyright © 2016年 zhangyun. All rights reserved.
//

import UIKit

class VCHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "拍一下"
        self.view.backgroundColor = VCBaseViewColor()
    
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        
        rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment(rawValue: 2)!

        rightButton.setImage(UIImage.init(named: "YXHomeCameCapture"), for: .normal)
        
        rightButton.tag = 101
        rightButton.addTarget(self, action: #selector(rightButtonClick), for: .touchUpInside)
        let item2=UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem = item2
        
        // Do any additional setup after loading the view.
    }

    
    
    func rightButtonClick(button: UIButton) {
        let seeAllVC = VCCamerViewController()
        navigationController?.pushViewController(seeAllVC, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
