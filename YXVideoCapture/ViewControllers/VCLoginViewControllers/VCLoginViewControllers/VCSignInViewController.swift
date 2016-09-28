//
//  VCSignInViewController.swift
//  YXVideoCapture
//
//  Created by admin on 16/9/25.
//  Copyright © 2016年 SYP. All rights reserved.
//

import UIKit
import MBProgressHUD
class VCSignInViewController: YXBaseViewController ,UITextFieldDelegate{

    var texUser = UITextField()
    var texPwd = UITextField()
    
    var signInButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = VCBaseViewColor()
        title = "注册"
        
        texUser = UITextField(frame: CGRect(x: 45, y: 150, width: SWIDTH-90, height: 44))
        texUser.delegate = self
        texUser.layer.cornerRadius = 5
        texUser.layer.borderColor = UIColor.lightGray.cgColor
        texUser.layer.borderWidth = 0.5
        texUser.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        texUser.leftViewMode = UITextFieldViewMode.always
        
        view.addSubview(texUser)
        
        //用户名输入框左侧图标
        let imgUser =  UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgUser.image = UIImage(named:"YXTexUser")
        
        texUser.leftView!.addSubview(imgUser)
        
        
        texPwd = UITextField(frame: CGRect(x: 45, y: 204, width: SWIDTH-90, height: 44))
        texPwd.delegate = self
        texPwd.layer.cornerRadius = 5
        texPwd.layer.borderColor = UIColor.lightGray.cgColor
        texPwd.isSecureTextEntry = true
        texPwd.layer.borderWidth = 0.5
        texPwd.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 44, height: 44))
        texPwd.leftViewMode = UITextFieldViewMode.always
        
        view.addSubview(texPwd)
        
        //密码输入框左侧图标
        let imgPwd =  UIImageView(frame:CGRect(x: 11, y: 11, width: 22, height: 22))
        imgPwd.image = UIImage(named:"YXTexPwd")
        texPwd.leftView!.addSubview(imgPwd)

        
        signInButton = UIButton(frame: CGRect(x:(SWIDTH-64)/2, y:texPwd.frame.origin.y+texPwd.frame.size.height+20, width:64, height:44))
        signInButton .setTitle("注册", for: .normal)
        signInButton .setTitleColor(UIColor.black, for: .normal)
        signInButton .addTarget(self, action: #selector(zhuceButTag), for: .touchUpInside)
        view .addSubview(signInButton)

        
        // Do any additional setup after loading the view.
    }

    func zhuceButTag() {
        
        let user = BmobUser()
        user.username = texUser.text
        user.password = texPwd.text
        //user.setObject(18, forKey: "age")
        user.signUpInBackground { (isSuccessful, error) in
            if isSuccessful {
               let _ =  self.navigationController?.popViewController(animated: false)
            }else{
                let er: NSError = error as! NSError
        
                let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                hud.mode = MBProgressHUDMode.text
                if er.code == 202 {
                    hud.label.text = "该账户已经注册过"
                }else if er.code == 20000 {
                   hud.label.text = "密码为空"
                }else {
                    hud.label.text = "请检查你的网络"
                }
                
                hud.hide(animated: true, afterDelay: 0.8)
            }
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
