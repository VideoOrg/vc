//
//  VCCamerViewController.swift
//  VideoCapture
//
//  Created by admin on 16/9/7.
//  Copyright © 2016年 zhangyun. All rights reserved.
//

import UIKit

class VCCamerViewController: UIViewController {
    var capView = UIView()
    var returnButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "拍摄"
        self.view.backgroundColor = VCBaseViewColor()
//        let rightButton = UIButton(frame: CGRectMake(0, 0, 44, 44))
//        rightButton.setTitle("拍摄", forState: UIControlState.Normal)
//        //rightButton.addTarget(self, action: #selector(rightButtonClick(_:)), forControlEvents: .TouchUpInside)
//        rightButton.tag = 101
//        rightButton.addTarget(self, action: #selector(righTag(_:)), forControlEvents: .TouchUpInside)
//        
//        let item2=UIBarButtonItem(customView: rightButton)
//        self.navigationItem.rightBarButtonItem = item2
        self.capView = UIView(frame: CGRectMake(0, 20, SWIDTH, SWIDTH))
        capView.backgroundColor = UIColor.redColor()
        view .addSubview(self.capView)
        
        
        self.returnButton = UIButton(frame: CGRectMake(0, 0, 44, 44))
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
     override  func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    func rightButtonClick(button: UIButton) {
        
    }
    
    func righTag(button: UIButton) {
        
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
