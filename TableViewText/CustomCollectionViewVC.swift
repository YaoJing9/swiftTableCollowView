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
    
    /// 行距
    private let hangSpace:Float = 10
    
    /// 列距
    private let lieSpace:Float = 10
    
    /// 间距
    private let marginSpace:Float = 5
    
    /// 列数
    private let lieCount = 4
    
    /// 是否是编辑状态
    private var isEdit:Bool =   false
    
    /// 所有items模型数组
    private var allItemModel:NSMutableArray =   NSMutableArray.init()
    
    private var _moveIndexP:IndexPath?
    private var _originalIndexP:IndexPath?
    private var _snapshotV:UIView?
    
    private let sectionHeaderID = "sectionHeaderID"
//    MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()

        let KWinW:Float = Float(self.view.bounds.size.width)
        
        //cell width
        let item_W:Float    =   (KWinW - marginSpace*2 - Float(lieCount-1)*lieSpace)/Float(lieCount)
        //cell height
        let item_H:Float    =   item_W*0.75
        
        flowLayout.itemSize =   CGSize.init(width: CGFloat(item_W), height: CGFloat(item_H))
        
        flowLayout.headerReferenceSize = CGSize.init(width: CGFloat(KWinW), height: 35)
        
        self.automaticallyAdjustsScrollViewInsets   =   false
            
        //注册CoutomeCollectionViewCell
        mainCollectionView.register(UINib.init(nibName: CoutomeCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: CoutomeCollectionViewCell.className)
        
        mainCollectionView.register(CollectionReusableHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier:sectionHeaderID)
        
        //rightBarButtonItem
        let button = UIButton.init(type: UIButtonType.custom)
        button.titleLabel?.font =   UIFont.systemFont(ofSize: 15)
        button.setTitle("编辑", for: UIControlState.normal)
        button.setTitle("完成", for: UIControlState.selected)
        button.sizeToFit()
        button.setTitleColor(UIColor.purple, for: UIControlState.normal)
        button.addTarget(self, action: #selector(clickEdit(butt:)), for: UIControlEvents.touchUpInside)
        self.navigationItem.rightBarButtonItem  =   UIBarButtonItem.init(customView: button)
        
        
        //添加长按手势
        let longPress:UILongPressGestureRecognizer = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressAction(recognizer:)))
        self.mainCollectionView.addGestureRecognizer(longPress)
    }

    @objc private func clickEdit(butt:UIButton) {
        print("点击了编辑")
        butt.isSelected =   !butt.isSelected
        self.isEdit =   butt.isSelected
        self.mainCollectionView.reloadData()
    }
    
    /// 长按响应
    @objc private func longPressAction( recognizer:UILongPressGestureRecognizer) -> Void {
        
        let touchPoint:CGPoint = recognizer.location(in: self.mainCollectionView)
        _moveIndexP =   self.mainCollectionView.indexPathForItem(at: touchPoint)
        
        switch recognizer.state {
        case .began:
            if !self.isEdit {
                self.isEdit =   !self.isEdit
                
                let managerButton:UIButton? = self.navigationItem.rightBarButtonItem?.customView as? UIButton
                managerButton?.isSelected = self.isEdit
                
                self.mainCollectionView.reloadData()
                self.mainCollectionView.layoutIfNeeded()
            }
            if  _moveIndexP != nil && _moveIndexP!.section == 0 {
                let cell:CoutomeCollectionViewCell = self.mainCollectionView.cellForItem(at: _moveIndexP!) as! CoutomeCollectionViewCell
                _originalIndexP =   self.mainCollectionView.indexPathForItem(at: touchPoint)
                if _originalIndexP==nil {
                    return
                }
                
                _snapshotV  =   cell.contentView.snapshotView(afterScreenUpdates: true)
                _snapshotV?.center  =   touchPoint
                self.mainCollectionView.addSubview(_snapshotV!)
                
                cell.isHidden   =   true
                UIView.animate(withDuration: 0.2, animations: { 
                    self._snapshotV?.transform   =   CGAffineTransform.init(scaleX: 1.03, y: 1.03)
                    self._snapshotV?.alpha   =   0.98
                })
            }
            break
        case .changed:
            _snapshotV?.center  =   touchPoint
            if _moveIndexP != nil && _moveIndexP!.section == 0 {
                if !(_moveIndexP?.elementsEqual(_originalIndexP!))! && (_moveIndexP?.section == _originalIndexP?.section){
                    
                    let sectionMD:CoutomeCollectionViewCellModel = self.dataMDMuAry[0] as! CoutomeCollectionViewCellModel
                    var itemAry:[Any] =  sectionMD.items
                    
                    let fromIndex = (_originalIndexP?.item)!
                    let toIndex = (_moveIndexP?.item)!
                    
                    let willExchangeObj = itemAry[fromIndex]
                    itemAry.remove(at: fromIndex)
                    itemAry.insert(willExchangeObj, at: toIndex)
                    sectionMD.items =   itemAry
                    
                    self.mainCollectionView.moveItem(at: _originalIndexP!, to: _moveIndexP!)
                    _originalIndexP =   _moveIndexP
                }
            }
            break
        case .ended:
            if _originalIndexP != nil {
                let cell:CoutomeCollectionViewCell? = self.mainCollectionView.cellForItem(at: _originalIndexP!) as? CoutomeCollectionViewCell
                cell?.isHidden   =   false
            }
            
            _snapshotV?.removeFromSuperview()
            break
        default: break
        }
        
    }
    
//MARK: -   UICollectionViewDataSource
    //区个数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let count = self.dataMDMuAry.count
        return count;
    }
    
    //对应区cell个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let model:CoutomeCollectionViewCellModel = self.dataMDMuAry[section] as! CoutomeCollectionViewCellModel

        let count = model.items.count
        return count;
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:CoutomeCollectionViewCell  =   CoutomeCollectionViewCell.getCoutomeCollectionViewCell(collectionView: collectionView, indexPath: indexPath);
    
        let sectionMD:CoutomeCollectionViewCellModel = self.dataMDMuAry[indexPath.section] as! CoutomeCollectionViewCellModel
        
        let itemMD = sectionMD.items[indexPath.row] as! Items
        
        if self.isEdit {
            if sectionMD.type! == "我的应用" {
                itemMD.itemStaue    =   ItemStaue_CanDelete
            }else{
                
                /// 判断当前item是否已添加到“我的应用”
                var isAdded = false
                
                //遍历我的应用,查找是否有当前item
                for i in 0..<(self.dataMDMuAry[0] as! CoutomeCollectionViewCellModel).items.count {
                    let itemMD_Zero =   (self.dataMDMuAry[0] as! CoutomeCollectionViewCellModel).items[i] as! Items
                    if itemMD_Zero.itemTitle! == itemMD.itemTitle! {
                        isAdded =   true
                        break//有立即跳出循环
                    }else{
                        itemMD.itemStaue    =   ItemStaue_CanAdd
                    }
                }
                //修改对应状态
                if isAdded {
                    itemMD.itemStaue    =   ItemStaue_HadAdd
                }else{
                    itemMD.itemStaue    =   ItemStaue_CanAdd
                }
            }
        }else{
            itemMD.itemStaue    =   ItemStaue_None
        }
        
        cell.itemMD = itemMD    //赋值
        
        cell.delegate =   self  //设置代理
        
        //闭包回调
        cell.clickEditClosureFunction { (itemMD_C) in
            print(itemMD_C.itemTitle + "-闭包调用")
            self.clickRightUpperButton(cell: cell)
        }
        
        return  cell;
    }
//MARK: -   CoutomeCollectionViewCellDelegate 代理
    func coutomeCollectionViewCell(_ cell: CoutomeCollectionViewCell, buttType: String) {
        print(buttType+"-代理回调")
    }
    
    /// 闭包回调|代理回调 中调用方法，更改CollectionView
    func clickRightUpperButton(cell:CoutomeCollectionViewCell) -> Void {
        let itemMD =    cell.itemMD
        
        if itemMD?.itemStaue == ItemStaue_CanAdd {
            print("添加")
            itemMD?.itemStaue   =   ItemStaue_HadAdd
            
            let newItemMD:Items = Items.init()
            newItemMD.imageName =   itemMD?.imageName
            newItemMD.itemTitle =   itemMD?.itemTitle
            newItemMD.itemStaue =   (itemMD?.itemStaue)!
            
            let sectionMD:CoutomeCollectionViewCellModel = self.dataMDMuAry[0] as! CoutomeCollectionViewCellModel
            sectionMD.items.append(newItemMD)
            
            let snapshotView:UIView = cell.snapshotView(afterScreenUpdates: true)!
            snapshotView.frame  =   cell.convert(cell.bounds, to: self.view)
            self.view.addSubview(snapshotView)
            
            self.mainCollectionView.reloadData()
            self.mainCollectionView.layoutIfNeeded()

            let lastCell:CoutomeCollectionViewCell = self.mainCollectionView.cellForItem(at: IndexPath.init(row: sectionMD.items.count-1, section: 0)) as! CoutomeCollectionViewCell
            lastCell.isHidden   =   true
            let targetFrame:CGRect = lastCell.convert(lastCell.bounds, to: self.view)
            
            UIView.animate(withDuration: 0.4, delay: 0, options: UIViewAnimationOptions.layoutSubviews, animations: {
                snapshotView.frame  =   targetFrame
            }, completion: { (finished) in
                snapshotView.removeFromSuperview()
                lastCell.isHidden   =   false
            })
            
        }else if itemMD?.itemStaue  == ItemStaue_CanDelete{
            print("可删除")
            let sectionMD:CoutomeCollectionViewCellModel = self.dataMDMuAry[0] as! CoutomeCollectionViewCellModel
            sectionMD.items.remove(at: (self.mainCollectionView.indexPath(for: cell)?.row)!)
            let itemMDs:[Items] = allItemModel as![Items]
            
            for item in itemMDs{
                if item.itemTitle == itemMD?.itemTitle {
                    item.itemStaue  =   ItemStaue_CanAdd
//                    break
                }
            }
            
            let snapshotV:UIView = cell.snapshotView(afterScreenUpdates: true)!
            snapshotV.frame =   cell.convert(cell.bounds, to: self.view)
            self.view.addSubview(snapshotV)
            
            cell.isHidden   =   true
            
            UIView.animate(withDuration: 0.4, animations: { 
                snapshotV.transform =   CGAffineTransform.init(scaleX: 0.1, y: 0.1)
            }, completion: { (finished) in
                snapshotV.removeFromSuperview()
                UIView.performWithoutAnimation {
                    self.mainCollectionView.reloadData()
                    cell.isHidden   =   false
                }
            })
        }
    }
    
//MARK: -   UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击cell")
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == UICollectionElementKindSectionHeader) {
            let  reusableV:CollectionReusableHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionHeaderID, for: indexPath) as! CollectionReusableHeaderView
            
            let sectionMD:CoutomeCollectionViewCellModel? = self.dataMDMuAry[indexPath.section] as? CoutomeCollectionViewCellModel
            reusableV.title =   sectionMD?.type
            
            return  reusableV
        }else {
            return UICollectionReusableView()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: - Lazy
    
    /// 初始数据字典数组，转化得到的数据模型
    lazy var dataMDMuAry = { () -> NSMutableArray in
        var dataAry = NSMutableArray.init(array: [
                                                ["type":"我的应用","items":NSMutableArray.init()],
                                                ["type":"便民生活","items":[
                                                                            ["imageName":"充值中心","itemTitle":"充值中心"],
                                                                            ["imageName":"信用卡还款","itemTitle":"信用卡还款"],
                                                                            ["imageName":"生活缴费","itemTitle":"生活缴费"],
                                                                            ["imageName":"城市服务","itemTitle":"城市服务"],
                                                                            ["imageName":"生活号","itemTitle":"生活号"],
                                                                            ["imageName":"到位","itemTitle":"到位"],
                                                                            ["imageName":"我的客服","itemTitle":"我的客服"],
                                                                            ["imageName":"我的快递","itemTitle":"我的快递"],
                                                                            ["imageName":"医疗健康","itemTitle":"医疗健康"],
                                                                            ["imageName":"记账本","itemTitle":"记账本"],
                                                                          ]
                                                ]
                                              ]
                                        )
        var muAry   =   NSMutableArray.init()
        let count   =   dataAry.count
        
        for i in 0..<count {
            let dic =   dataAry[i] as! NSDictionary
            let model:CoutomeCollectionViewCellModel    =   CoutomeCollectionViewCellModel.init(objectWith: dic as! [AnyHashable : Any])
            let items:[Items]   =   model.items as! [Items]
            if model.type == "我的应用"{
                for itemMD in items {
                    itemMD.itemStaue    =   ItemStaue_HadAdd
                }
            }else{
                self.allItemModel.addObjects(from: items)
            }
            
            muAry.add(model)
        }
        return muAry
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

