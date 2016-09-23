//
//  VCLoginViewContoller.swift
//  YXVideoCapture
//
//  Created by admin on 16/9/23.
//  Copyright © 2016年 SYP. All rights reserved.
//

import UIKit

class VCLoginViewContoller: YXBaseViewController ,UITextFieldDelegate{

    var texUser = UITextField()
    var texPwd = UITextField()
    
    var offsetLeftHand:CGFloat = 60
    
//    //左手图片,右手图片(遮眼睛的)
//    var imageLeftArm = UIImageView()
//    var imageRightArm = UIImageView()
//    
//    //左手图片,右手图片(圆形的)
//    var imageLeftArmGone:UIImageView()
//    var imageLeftArmGone:UIImageView()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = VCBaseViewColor()
        
        texUser = UITextField(frame: CGRect(x: 30, y: 30, width: SWIDTH-60, height: 44))
        texUser.delegate = self
        texUser.layer.cornerRadius = 5
        texUser.layer.borderColor = UIColor.lightGray.cgColor
        texUser.layer.borderWidth = 0.5
        texUser.leftViewMode = UITextFieldViewMode.always
        
        view.addSubview(texUser)
        
        
        texPwd = UITextField(frame: CGRect(x: 30, y: 80, width: SWIDTH-60, height: 44))
        texPwd.delegate = self
        texPwd.layer.cornerRadius = 5
        texPwd.layer.borderColor = UIColor.lightGray.cgColor
        texPwd.isSecureTextEntry = true
        texPwd.layer.borderWidth = 0.5
        texPwd.leftViewMode = UITextFieldViewMode.always
        
        view.addSubview(texPwd)

        
        
        // Do any additional setup after loading the view.
    }

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.isEqual(texUser) {
        }
        
        
        
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
