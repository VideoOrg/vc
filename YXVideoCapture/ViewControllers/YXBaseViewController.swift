//
//  YXBaseViewController.swift
//  YXVideoCapture
//
//  Created by admin on 16/9/20.
//  Copyright © 2016年 SYP. All rights reserved.
//

import UIKit

class YXBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backItem:UIBarButtonItem = UIBarButtonItem(image:UIImage.init(named: "YXNavigationBack"), style:UIBarButtonItemStyle.plain , target:self, action: #selector(comeBackTag))
        self.navigationItem.leftBarButtonItem = backItem
        // Do any additional setup after loading the view.
    }

    func comeBackTag(){
        let _ =  navigationController?.popViewController(animated: false)
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
