//
//  VCAVPlayerView.swift
//  YXVideoCapture
//
//  Created by admin on 16/9/23.
//  Copyright © 2016年 SYP. All rights reserved.
//

import UIKit
import AVFoundation
class VCAVPlayerView: UIView {
    
    var playerLayer = AVPlayerLayer()


    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = self.bounds
        
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
