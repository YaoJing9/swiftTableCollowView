//
//  CustomCollectionViewVC.swift
//  TableViewText
//
//  Created by thinkjoy on 2017/7/11.
//  Copyright © 2017年 杜瑞胜. All rights reserved.
//

import UIKit


class CustomCollectionViewVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CoutomeCollectionViewCellDelegate {

    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let KWinW:Float = Float(self.view.bounds.size.width)
//        let KWinH:Float = Float(self.view.bounds.size.height)
        
        
        
        
        /// 行距
//        let hangSpace:Float = 10
        
        /// 列距
        let lieSpace:Float = 10
        
        let marginSpace:Float = 5
        
        let lieCount = 4
        
        
        let item_W:Float    =   (KWinW - marginSpace*2 - Float(lieCount-1)*lieSpace)/Float(lieCount)
        let item_H:Float    =   item_W*0.75
        
        
        
        flowLayout.itemSize =   CGSize.init(width: CGFloat(item_W), height: CGFloat(item_H))
        
        // Do any additional setup after loading the view.
        
        
        mainCollectionView.register(UINib.init(nibName: CoutomeCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: CoutomeCollectionViewCell.className)
        
        self.navigationItem.rightBarButtonItem  =   UIBarButtonItem.init(title: "编辑", style: UIBarButtonItemStyle.done, target: self, action: #selector(clickEdit))
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
//        
//    }
    
    
    func clickEdit() {
        print("点击了编辑")
//        mainCollectionView.endEditing(false)
//        mainCollectionView.allowsMultipleSelection  =   true
//        mainCollectionView.selectItem(at: nil, animated: true, scrollPosition: UICollectionViewScrollPosition())
        
        
    }
//MARK: -   UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let count = self.dataAry.count
        print("\(count)区")
        return count;
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let cellDic:NSDictionary =   self.dataAry[section] as! NSDictionary
        
        let cellAry:NSArray = cellDic["items"] as! NSArray
        
        let count = cellAry.count
        print("\(count)行")
        return count;
//        return 8;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell:CoutomeCollectionViewCell  =   CoutomeCollectionViewCell().getCoutomeCollectionViewCell(withCollectionView:collectionView,for: indexPath)
        
        let cell:CoutomeCollectionViewCell  =   CoutomeCollectionViewCell.getCoutomeCollectionViewCell(collectionView: collectionView, indexPath: indexPath);
    
        let cellDic:NSDictionary =   self.dataAry[indexPath.section] as! NSDictionary
        let cellAry:NSArray = cellDic["items"] as! NSArray
        
        let dic = cellAry[indexPath.row] as! NSDictionary
        let str = dic["itemTitle"] as! String
        
        cell.titStr = str
        //"\(indexPath.section)区-\(str)行"
        cell.delegate =   self
        
        cell.clickEditClosureFunction { (editType) in
            print(editType+"-闭包调用")
        }
        
        return  cell;
    }
//MARK: -   UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击cell")
        
//        if indexPath.row>5 {
//            mainCollectionView.deselectItem(at: indexPath, animated: true)
////            mainCollectionView.reloadItems(at: [indexPath])
//            let cellAry:NSMutableArray = self.dataAry[indexPath.section] as! NSMutableArray
//            
//            if cellAry.count==1 {
//                self.dataAry.removeObject(at: indexPath.section)
//            }else{
//                cellAry.removeObject(at: indexPath.row)
//                self.dataAry.replaceObject(at: indexPath.section, with: cellAry)
//                
//            }
//            mainCollectionView.reloadData()
//        }
        
//        if #available(iOS 9.0, *) {
//            mainCollectionView.beginInteractiveMovementForItem(at: indexPath)
//        } else {
//            // Fallback on earlier versions
//        }
        
//        collectionView.moveItem(at: indexPath, to: IndexPath.init(row: 0, section: 0))
//        collectionView.moveSection(1, toSection: 0)
        
//        let cellAry:NSMutableArray = self.dataAry[indexPath.section] as! NSMutableArray
//        cellAry.insert("插入", at: indexPath.row)
//        self.dataAry.replaceObject(at: indexPath.section, with: cellAry)
//        
//        collectionView.insertItems(at: [indexPath])
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: -   CoutomeCollectionViewCellDelegate
    func coutomeCollectionViewCell(_ cell: CoutomeCollectionViewCell, buttType: String) {
        print(buttType+"-代理调用")
    }
    
//MARK: - move
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return  true
    }
    
//MARK: - Lazy
    lazy var dataAry = { () -> NSMutableArray in
        var muAry = NSMutableArray.init(array: [
                                                ["type":"我的应用","items":NSMutableArray.init()],
                                                ["type":"我的应用","items":[
                                                                            ["imageName":"充值中心","itemTitle":"充值中心"],
                                                                            ["imageName":"信用卡还款","itemTitle":"信用卡还款"]
                                                                          ]
                                                ]
                                              ]
                                        )
        return  muAry
    }()
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

