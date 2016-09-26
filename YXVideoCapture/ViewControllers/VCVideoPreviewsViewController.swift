//
//  VCVideoPreviewsViewController.swift
//  YXVideoCapture
//
//  Created by admin on 16/9/19.
//  Copyright © 2016年 SYP. All rights reserved.
//

import UIKit
import AVFoundation
class VCVideoPreviewsViewController: YXBaseViewController {
 
    var playerLayer = AVPlayerLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = VCBaseViewColor()
        title = "预览"
        
        let  url  = NSURL(string: "http://bos.nj.bpc.baidu.com/tieba-smallvideo/11772_3c435014fb2dd9a5fd56a57cc369f6a0.mp4")
        
        let playerItem:AVPlayerItem = AVPlayerItem.init(url: url as! URL)
        
        //playerItem.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.new, context: nil)
        
        
        let avplayer = AVPlayer(playerItem : playerItem)
        
        playerLayer.player = avplayer
        playerLayer.frame = CGRect(x:0 , y:64 , width : SWIDTH ,height:SWIDTH)
        
        
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspect
        playerLayer.contentsScale = UIScreen.main.scale
        
        
        view.layer.addSublayer(playerLayer)
        
       avplayer.play()
        
        
        // Do any additional setup after loading the view.
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
