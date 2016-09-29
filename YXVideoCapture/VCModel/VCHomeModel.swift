//
//  VCHomeModel.swift
//  YXVideoCapture
//
//  Created by admin on 16/9/29.
//  Copyright © 2016年 SYP. All rights reserved.
//

import UIKit

class VCHomeModel: NSObject {

  
    var videoRemoteURL: String?
    
    init(dictionary: [String: AnyObject]) {
         super.init()
        videoRemoteURL = dictionary["videoRemoteURL"] as? String
    }

}
