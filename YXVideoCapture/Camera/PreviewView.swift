//
//  PreviewView.swift
//  VC
//
//  Created by zhangyun on 2016/9/12.
//  Copyright © 2016年 zhangyun. All rights reserved.
//

import UIKit
import AVFoundation

class PreviewView: UIView {
    
    var session: AVCaptureSession {
        get{
           return (self.layer as! AVCaptureVideoPreviewLayer).session
        }
        set {
            (self.layer as! AVCaptureVideoPreviewLayer).session = newValue
        }
    }
    
    internal override class var layerClass : AnyClass {
         return AVCaptureVideoPreviewLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        
        let vlayer: AVCaptureVideoPreviewLayer =  self.layer as! AVCaptureVideoPreviewLayer
        vlayer.videoGravity = AVLayerVideoGravityResizeAspectFill
    }
}
