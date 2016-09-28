//
//  VCMyViewController.swift
//  YXVideoCapture
//
//  Created by admin on 16/9/26.
//  Copyright © 2016年 SYP. All rights reserved.
//

import UIKit

class VCMyViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {

    
    var dataArry = NSMutableArray()
    
     var logoutButton = UIButton()
    
    var footliveView = UIView()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = VCBaseViewColor()
        title = "我的"
        
        let user = BmobUser.current()
        
        dataArry = [user?.username,"修改密码"]
        
        //之前这个地方定义的是var tableView局部变量，导致点了delete没反应
        let  tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SWIDTH, height:SHEIGHT))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        //tableView.isScrollEnabled = false
        self.view.addSubview(tableView)
        tableView.tableFooterView = self .addFootView()
               // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addFootView() -> UIView {
        
        let footView = UIView(frame: CGRect(x: 0, y: 0, width: SWIDTH, height: 50))
        
        self.footliveView = UIView(frame: CGRect(x: 0, y: 0, width: SWIDTH, height: 0.5))
        self.footliveView.backgroundColor = UIColor.black
        footView .addSubview(self.footliveView)
        
        self.logoutButton = UIButton(frame: CGRect(x:0, y:0, width:SWIDTH, height:50))
       self.logoutButton .setTitle("退出登录", for: .normal)
        self.logoutButton .setTitleColor(UIColor.black, for: .normal)
        self.logoutButton .addTarget(self, action: #selector(logoutButTag), for: .touchUpInside)
        footView .addSubview(self.logoutButton)

        
        return footView
    }

    //每一块有多少行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArry.count
    }
    //绘制cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let initIdentifier = "Cell"
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: initIdentifier)
        //下面两个属性对应subtitle
        cell.textLabel?.text = dataArry[indexPath.row]as?String
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func logoutButTag(button: UIButton) {
        BmobUser.logout()
       
        let appdelegate = UIApplication.shared.delegate as? AppDelegate
        appdelegate?.switchRootViewController()
        
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
