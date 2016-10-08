//
//  VCCamerViewController.swift
//  VideoCapture
//
//  Created by admin on 16/9/7.
//  Copyright © 2016年 zhangyun. All rights reserved.
//

import UIKit
import Photos
import MBProgressHUD
//import snapKit


class VCCamerViewController: UIViewController {
    var topView  = UIView()
    var capView = UIView()
    var topCameRotateButton = UIButton()
    var returnButton = UIButton()
    var startOrSTopButton = UIButton()
    var finishViedoButon = UIButton()
    var previewView: PreviewView!
    var cameraController: CameraController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = VCBaseViewColor()
        
        NotificationCenter.default.addObserver(self, selector: Selector("hideMB"), name: NSNotification.Name(rawValue: "hideMb"), object: nil)
        
        self.topView = UIView(frame: CGRect(x: 0, y: 20, width: SWIDTH, height: 44))
        self.topView.backgroundColor = UIColor.white
        view .addSubview(self.topView)
        
        self.topCameRotateButton = UIButton(frame: CGRect(x: SWIDTH - 44, y:0, width:44, height:44))
        self.topCameRotateButton .setImage(UIImage.init(named: "YXCameRotate"), for: .normal)
        self.topCameRotateButton .setTitleColor(UIColor.black, for: .normal)
        self.topCameRotateButton .addTarget(self, action: #selector(topCameRotateButTag), for: .touchUpInside)
        self.topView .addSubview(self.topCameRotateButton)

        self.capView = UIView(frame: CGRect(x: 0, y: 64, width: SWIDTH, height: SWIDTH))
        capView.backgroundColor = UIColor.clear
        view .addSubview(self.capView)
        showPreviewLayer()
        
        self.returnButton = UIButton(frame: CGRect(x:0, y:SWIDTH+30+20+44, width:64, height:64))
        self.returnButton .setImage(UIImage.init(named: "YXCameClose"), for: .normal)
        self.returnButton .setTitleColor(UIColor.black, for: .normal)
        self.returnButton .addTarget(self, action: #selector(returnTag), for: .touchUpInside)
        view .addSubview(self.returnButton)
        
        self.startOrSTopButton = UIButton(frame:CGRect(x:150, y:SWIDTH+50+44, width:82, height:82))
        self.startOrSTopButton .setImage(UIImage.init(named: "YXCameStart"), for: .normal)
        self.startOrSTopButton .addTarget(self, action: #selector(startOrSTopTag), for: .touchUpInside)
        view .addSubview(self.startOrSTopButton)

        self.finishViedoButon = UIButton(frame:CGRect(x:300, y:SWIDTH+50+44, width:64, height:64))
        self.finishViedoButon .setImage(UIImage.init(named: "YXCameFinish"), for: .normal)
        self.finishViedoButon .addTarget(self, action: #selector(finishViedoTag), for: .touchUpInside)
        view .addSubview(self.finishViedoButon)
        
    }
    
    func hideMB() {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        
        let hud1 = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud1.mode = .text
        hud1.customView = UIImageView(image: UIImage(named: "pic_dui@2x"))
        hud1.label.text = "上传完成"
        hud1.hide(animated: true, afterDelay: 1)
        
    }

     override  func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    //MARK: - Capture
    
    /// show preview
    func showPreviewLayer() {
        self.previewView =  PreviewView(frame: self.capView.bounds)
        self.capView.addSubview(self.previewView)
        
         self.cameraController = CameraController()
        self.cameraController.setupSession()
        
        self.previewView.session = self.cameraController.captureSession
        self.cameraController.startSession()
    }
    
    
    //MARK: - action
    func rightButtonClick(button: UIButton) {
        
    }
    
    func topCameRotateButTag(button:UIButton) {
        self.cameraController.switchCamera()
    }
    
    func returnTag(button:UIButton) {
      let _ =  navigationController?.popViewController(animated: false)
    }
    
    func startOrSTopTag(button:UIButton) {
        self.startOrSTopButton .isEnabled = false
        self.cameraController.startRecording()
    }
    
    func finishViedoTag(button:UIButton) {
        self.startOrSTopButton .isEnabled = true
        self.cameraController.stopRecording()
        
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "上传中..."
        hud.show(animated: true)
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
