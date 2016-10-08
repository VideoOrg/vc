//
//  VCLoginViewContoller.swift
//  YXVideoCapture
//
//  Created by admin on 16/9/23.
//  Copyright © 2016年 SYP. All rights reserved.
//

import UIKit
import MBProgressHUD

class VCLoginViewContoller: YXBaseViewController ,UITextFieldDelegate {

    var texUser = UITextField()
    var texPwd = UITextField()
    
    var offsetLeftHand:CGFloat = 60
    
    //左手图片,右手图片(遮眼睛的)
    var imageLeftArm = UIImageView()
    var imageRightArm = UIImageView()
    
    //左手图片,右手图片(圆形的)
    var imageLeftArmGone = UIImageView()
    var imageRigthArmGone = UIImageView()
    
    //登录框状态
    var showType:LoginShowType = LoginShowType.NONE
    
    var loginButton = UIButton()
    
    var signInButton = UIButton()
    
    
    
    override  func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = VCBaseViewColor()
        
        
        //猫头鹰头部
        let imgLogin =  UIImageView(frame: CGRect(x: (SWIDTH/2-211/2), y: 100, width: 211, height: 109))
        imgLogin.image = UIImage(named:"YXLoginIcon")
        imgLogin.layer.masksToBounds = true
        view.addSubview(imgLogin)
        
        //猫头鹰左手(遮眼睛的)
        let rectLeftHand = CGRect(x: (imgLogin.frame.size.width / 2 - 100), y: 90, width: 40, height: 65)
        imageLeftArm = UIImageView(frame:rectLeftHand)
        imageLeftArm.image = UIImage(named:"YXLoginArmLeft")
        imgLogin.addSubview(imageLeftArm)
        
        //猫头鹰右手(遮眼睛的)
        
        let rectRightHand = CGRect(x: (imgLogin.frame.size.width / 2 + 62), y: 90, width: 40, height: 65)
        imageRightArm = UIImageView(frame:rectRightHand)
        imageRightArm.image = UIImage(named:"YXLoginArmRight")
        imgLogin.addSubview(imageRightArm)
        
        
        //登录框背景
        let vLogin =  UIView(frame: CGRect(x: 15, y: 200, width: SWIDTH-30, height: 160))
        vLogin.layer.borderWidth = 0.5
        vLogin.layer.cornerRadius = 10
        vLogin.layer.borderColor = UIColor.lightGray.cgColor
        vLogin.backgroundColor = UIColor.white
        view.addSubview(vLogin)
        
        
        //猫头鹰左手(圆形的)
        let rectLeftHandGone = CGRect(x: SWIDTH/2-100 , y: vLogin.frame.origin.y - 22, width: 40, height: 40)
        imageLeftArmGone = UIImageView(frame:rectLeftHandGone)
        imageLeftArmGone.image = UIImage(named:"YXLoginHand")
        self.view.addSubview(imageLeftArmGone)
        
        //猫头鹰右手(圆形的)
        let rectRightHandGone = CGRect(x: SWIDTH/2+62 , y: vLogin.frame.origin.y - 22, width: 40, height: 40)
        
        imageRigthArmGone = UIImageView(frame:rectRightHandGone)
        imageRigthArmGone.image = UIImage(named:"YXLoginHand")
        self.view.addSubview(imageRigthArmGone)

    
        texUser = UITextField(frame: CGRect(x: 30, y: 30, width: SWIDTH-90, height: 44))
        texUser.delegate = self
        texUser.layer.cornerRadius = 5
        texUser.layer.borderColor = UIColor.lightGray.cgColor
        texUser.layer.borderWidth = 0.5
        texUser.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        texUser.leftViewMode = UITextFieldViewMode.always
        
        vLogin.addSubview(texUser)
        
        //用户名输入框左侧图标
        let imgUser =  UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgUser.image = UIImage(named:"YXTexUser")
        
        texUser.leftView!.addSubview(imgUser)
       
        
        texPwd = UITextField(frame: CGRect(x: 30, y: 90, width: SWIDTH-90, height: 44))
        texPwd.delegate = self
        texPwd.layer.cornerRadius = 5
        texPwd.layer.borderColor = UIColor.lightGray.cgColor
        texPwd.isSecureTextEntry = true
        texPwd.layer.borderWidth = 0.5
        texPwd.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 44, height: 44))
        texPwd.leftViewMode = UITextFieldViewMode.always
        
        vLogin.addSubview(texPwd)

        //密码输入框左侧图标
        let imgPwd =  UIImageView(frame:CGRect(x: 11, y: 11, width: 22, height: 22))
        imgPwd.image = UIImage(named:"YXTexPwd")
        texPwd.leftView!.addSubview(imgPwd)

        
        
        loginButton = UIButton(frame: CGRect(x:vLogin.frame.origin.x+30, y:vLogin.frame.origin.y+vLogin.frame.size.height+20, width:64, height:44))
        loginButton .setTitle("登录", for: .normal)
        loginButton .setTitleColor(UIColor.black, for: .normal)
        loginButton .addTarget(self, action: #selector(loginButTag), for: .touchUpInside)
        view .addSubview(loginButton)
    
        
        signInButton = UIButton(frame: CGRect(x:vLogin.frame.origin.x+vLogin.frame.size.width-30-64, y:vLogin.frame.origin.y+vLogin.frame.size.height+20, width:64, height:44))
       
        signInButton .setTitle("注册", for: .normal)
        
        signInButton .setTitleColor(UIColor.black, for: .normal)
        signInButton .addTarget(self, action: #selector(zhuceButTag), for: .touchUpInside)
        view .addSubview(signInButton)

        
        // Do any additional setup after loading the view.
    }

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        //如果当前是用户名输入
        if textField.isEqual(texUser){
            if (showType != LoginShowType.PASS)
            {
                showType = LoginShowType.USER
                return
            }
            showType = LoginShowType.USER
            
            //播放不遮眼动画
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.imageLeftArm.frame = CGRect(
                    x:self.imageLeftArm.frame.origin.x - self.offsetLeftHand,
                    y:self.imageLeftArm.frame.origin.y + 30,
                    width:self.imageLeftArm.frame.size.width,
                    height:self.imageLeftArm.frame.size.height)
                
                self.imageRightArm.frame = CGRect(
                    x:self.imageRightArm.frame.origin.x + 48,
                    y:self.imageRightArm.frame.origin.y + 30,
                    width:self.imageRightArm.frame.size.width,
                    height:self.imageRightArm.frame.size.height)
                
                self.imageLeftArmGone.frame = CGRect(x: self.imageLeftArmGone.frame.origin.x - 70 , y:self.imageLeftArmGone.frame.origin.y ,width:40, height: 40)
                
                
                self.imageRigthArmGone.frame = CGRect(x: self.imageRigthArmGone.frame.origin.x + 30 , y:self.imageRigthArmGone.frame.origin.y ,width:40, height: 40)
                
                
            })
        }
            //如果当前是密码名输入
        else if textField.isEqual(texPwd){
            if (showType == LoginShowType.PASS)
            {
                showType = LoginShowType.PASS
                return
            }
            showType = LoginShowType.PASS
            
            //播放遮眼动画
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.imageLeftArm.frame = CGRect(
                    x:self.imageLeftArm.frame.origin.x + self.offsetLeftHand,
                    y:self.imageLeftArm.frame.origin.y - 30,
                    width:self.imageLeftArm.frame.size.width,
                    height: self.imageLeftArm.frame.size.height)
                
                self.imageRightArm.frame = CGRect(
                    x:self.imageRightArm.frame.origin.x - 48,
                    y:self.imageRightArm.frame.origin.y - 30,
                    width:self.imageRightArm.frame.size.width,
                    height:self.imageRightArm.frame.size.height)


                self.imageLeftArmGone.frame = CGRect(x:self.imageLeftArmGone.frame.origin.x + 70,
                                                      y:self.imageLeftArmGone.frame.origin.y ,
                                                      width:0 ,
                                                      height:0)
                
                self.imageRigthArmGone.frame = CGRect(x:self.imageRigthArmGone.frame.origin.x - 30,
                                                     y:self.imageRigthArmGone.frame.origin.y ,
                                                     width:0 ,
                                                     height:0)
                
            })
        }
    }
    
    
    func loginButTag() {
        BmobUser.loginWithUsername(inBackground: texUser.text, password: texPwd.text) { (bmobuer, error) in
            if bmobuer != nil {
            let appdelegate = UIApplication.shared.delegate as? AppDelegate
                appdelegate?.switchRootViewController()
            }else{
                let er: NSError = error as! NSError
                let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                hud.mode = MBProgressHUDMode.text
                 print("login error \(error)")
                if er.code == 101 {
                    hud.label.text = "账户或密码错误"
                }else if  er.code == 20001{
                    hud.label.text = "账户为空"
                }else if  er.code == 2000{
                    hud.label.text = "密码为空"
                }else{
                    hud.label.text = "请检查你的网络"
                }
                hud.hide(animated: true, afterDelay: 0.8)

            }
        }
    }

    func zhuceButTag() {
        
        let SignInViewController = VCSignInViewController()
        navigationController?.pushViewController(SignInViewController, animated: false)
        
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
//登录框状态枚举
enum LoginShowType {
    case NONE
    case USER
    case PASS
}
