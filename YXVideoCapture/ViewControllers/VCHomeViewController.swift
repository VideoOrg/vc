//
//  VCHomeViewController.swift
//  VideoCapture
//
//  Created by admin on 16/9/5.
//  Copyright © 2016年 zhangyun. All rights reserved.
//

import UIKit
import Kingfisher
class VCHomeViewController: UIViewController  ,UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "主页"
        self.view.backgroundColor = VCBaseViewColor()
        
        
        
//        let leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
//        leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment(rawValue: 1)!
//        leftButton .setTitle("我", for: .normal)
//        leftButton .setTitleColor(UIColor.black, for: .normal)
//        leftButton.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
//        let item1=UIBarButtonItem(customView: leftButton)
//        self.navigationItem.leftBarButtonItem = item1
//
//    
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        
        rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment(rawValue: 2)!

        rightButton.setImage(UIImage.init(named: "YXHomeCameCapture"), for: .normal)
        
        rightButton.tag = 101
        rightButton.addTarget(self, action: #selector(rightButtonClick), for: .touchUpInside)
        let item2=UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem = item2
        
        
        self.automaticallyAdjustsScrollViewInsets = false
        // 1.自定义 Item 的FlowLayout
        
        
        let flowLayout = UICollectionViewFlowLayout()
        
        // 2.设置 Item 的 Size
        flowLayout.itemSize = CGSize(width: (SWIDTH-2)/2 , height:  (SWIDTH-2)/2)
        
        // 3.设置 Item 的排列方式
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        
        // 4.设置 Item 的四周边距
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        // 5.设置同一竖中上下相邻的两个 Item 之间的间距
        flowLayout.minimumLineSpacing = CGFloat(integerLiteral: 1)
//        
//        // 6.设置同一行中相邻的两个 Item 之间的间距
        flowLayout.minimumInteritemSpacing = CGFloat(integerLiteral: 1)
        
        // 7.设置UICollectionView 的页头尺寸
        //flowLayout.headerReferenceSize = CGSize(width:100,height: 50)
        
        // 8.设置 UICollectionView 的页尾尺寸
       // flowLayout.footerReferenceSize = CGSize(width:100, height: 50)
        
        
        // 1.自定义 UICollectionView 的位置大小, 以及 Item 的显示样式为 flowLayout
        let collection = UICollectionView(frame: CGRect(x:0,y: 64, width:self.view.frame.width,  height:self.view.frame.height-64-49), collectionViewLayout: flowLayout)
        
        // 2.设置 UICollectionView 的背景颜色
        collection.backgroundColor = UIColor.white
        
        // 3.设置 UICollectionView 垂直滚动是否滚到 Item 的最底部内容
        collection.alwaysBounceVertical = true
        
        // 4.设置 UICollectionView 垂直滚动是否滚到 Item 的最右边内容
       // collection.alwaysBounceHorizontal = true
        
        // 5.设置 UICollectionView 的数据源对象
        collection.dataSource = self
        
        // 6.设置 UICollectionView 的代理对象
        collection.delegate = self
        
    
        // 7.设置 UICollectionView 的单元格点击(默认是 true)
        collection.allowsSelection = true
        
        // 8.设置 UICollectionView 的单元格多选(默认是 false)
        collection.allowsMultipleSelection = false
        
        // 9.开启 UICollectionView 的分页显示效果
        collection.isPagingEnabled = true
        
        // 10.注册 UICollectionViewCell
        collection.register(YXHomeCollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        // 11.添加到 self.view 上
        self.view.addSubview(collection)        // Do any additional setup after loading the view.
        
        
       // let  file = obj.objectForKey("file") as? BmobFile
        
        
        
    }


    
    // 1.该方法是用来设置返回 CollectionViewCell 的组数
    //private func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
      //  return 1
    //}
    
    // 2.该方法是用来设置返回 CollectionViewCell 的个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 60
    }
    
    // 3.该方法是用来设置 CollectionViewCell 的内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath as IndexPath) as! YXHomeCollectionViewCell
        collectionCell.backgroundColor = UIColor.red
        let imageR = ImageResource(downloadURL: URL(string: "http://pic26.nipic.com/20121217/9252150_110558501000_2.jpg")!)
        collectionCell.imgView?.kf_setImage(with: imageR)
        return collectionCell
    }
    
    // 4.该方法是点击了 CollectionViewCell 时调用的监听方法
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoPreviews = VCVideoPreviewsViewController()
        navigationController?.pushViewController(videoPreviews, animated: false)
    }
    
    // 5.该方法是用来设置 CollectionViewCell 的大小
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width:  (SWIDTH-2)/2, height:  (SWIDTH-2)/2)
    }
    
    // 6.该方法是用来设置 CollectionViewCell 四周的边距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    // 7.该方法是用来设置同一行 CollectionViewCell 之间的间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    
    // 8.该方法是用来设置同一列 CollectionViewCell 之间的间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    
    // 9.该方法是用来设置 CollectionView 的页头尺寸
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: 100, height: 100)
//    }
//    
//    // 10.该方法是用来设置 CollectionView 的页尾尺寸
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        return CGSize(width: 100, height: 100)
//    }

    
    func rightButtonClick(button: UIButton) {
        let seeAllVC = VCCamerViewController()
        navigationController?.pushViewController(seeAllVC, animated: false)
    }
    
    func leftButtonClick(button: UIButton) {
        let MyViewVC = VCMyViewController()
        navigationController?.pushViewController(MyViewVC, animated: false)
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

