//
//  VCAdvertisementViewController.swift
//  YXVideoCapture
//
//  Created by admin on 16/10/12.
//  Copyright © 2016年 SYP. All rights reserved.
//

import UIKit

class VCAdvertisementViewController: YXBaseViewController {
    var screenImage = UIImageView()
    var screenButton = UIButton()
    var jumpButton = UIButton()
    var timer  =  Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        screenImage=UIImageView(image:UIImage(named:"VCScreenAdv"))
        screenImage.frame = (frame: CGRect(x: 0, y: 0, width: SWIDTH, height: SHEIGHT))
        screenImage.isUserInteractionEnabled  = true
        self.view.addSubview(screenImage)
        
        screenButton = UIButton(frame: CGRect(x: 0, y: 0, width: SWIDTH, height: SHEIGHT))

        screenButton.addTarget(self, action: #selector(screenButTag), for: .touchUpInside)
        screenImage .addSubview(screenButton)
        
        jumpButton = UIButton(frame: CGRect(x: SWIDTH-72, y: 30, width: 62, height: 36))
        jumpButton.addTarget(self, action: #selector(jumpButTag), for: .touchUpInside)
        jumpButton.setTitle("跳过", for: .normal)
        screenImage .addSubview(jumpButton)
    
        self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(VCAdvertisementViewController.timerFired), userInfo: nil, repeats: true)
        
        // 将定时器添加到运行循环
        RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
        // Do any additional setup after loading the view.
    }
    func screenButTag() {
        let appdelegate = UIApplication.shared.delegate as? AppDelegate
        appdelegate?.switchRootViewController()
        //取消定时器
        timer .invalidate()
    }
    func jumpButTag() {
        let appdelegate = UIApplication.shared.delegate as? AppDelegate
        appdelegate?.switchRootViewController()
        //取消定时器
        timer .invalidate()
        
    }
    func timerFired () {
        //print("timer ticked")
        let appdelegate = UIApplication.shared.delegate as? AppDelegate
        appdelegate?.switchRootViewController()

        timer .invalidate()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
