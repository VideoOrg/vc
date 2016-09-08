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
    var startOrSTopButton = UIButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "拍摄"
        self.view.backgroundColor = VCBaseViewColor()
        
        self.capView = UIView(frame: CGRectMake(0, 20, SWIDTH, SWIDTH))
        capView.backgroundColor = UIColor.redColor()
        view .addSubview(self.capView)
        
        
        self.returnButton = UIButton(frame: CGRectMake(0, SWIDTH+30+20, 44, 44))
        self.returnButton .setTitle("返回", forState: UIControlState.Normal)
        self.returnButton .addTarget(self, action: #selector(returnTag(_:)), forControlEvents: .TouchDragInside)
        view .addSubview(self.returnButton)
        
        self.startOrSTopButton = UIButton(frame:CGRectMake(150,SWIDTH+50,100,100))
        self.startOrSTopButton .setTitle("开始", forState: UIControlState.Normal)
        self.startOrSTopButton .setTitle("暂定", forState: UIControlState.Selected)
        view .addSubview(self.startOrSTopButton)

        
        
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
    
    func returnTag(button:UIButton) {
        
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
