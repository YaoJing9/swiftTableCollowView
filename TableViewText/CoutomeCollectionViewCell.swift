//
//  CoutomeCollectionViewCell.swift
//  TableViewText
//
//  Created by thinkjoy on 2017/7/11.
//  Copyright © 2017年 杜瑞胜. All rights reserved.
//

import UIKit


/// 代理
@objc protocol CoutomeCollectionViewCellDelegate : NSObjectProtocol{
    /// 可选代理
    @objc optional func coutomeCollectionViewCell(_ cell:CoutomeCollectionViewCell,buttType:String)
}

///  声明一个闭包别名，闭包含字符串类型的两个参数，无返回值(使用“（）”或者“Void”都一样)
typealias EditClosure = (_ item:Items) -> Void


class CoutomeCollectionViewCell: UICollectionViewCell {

    
    /// 声明代理属性
    weak var delegate:CoutomeCollectionViewCellDelegate?
    
    /// 闭包声明
    private var clickEditClosure:EditClosure?
    
    /// 触发闭包调用方法，给外部外部调用
    func clickEditClosureFunction(closure:@escaping EditClosure) {
        clickEditClosure =   closure
    }
    
    //xib上的控件
    @IBOutlet weak private var itemImgV: UIImageView!
    @IBOutlet weak private var itemLab: UILabel!
    
    @IBOutlet weak private var buttView: UIView!
    @IBOutlet weak private var itemButt: UIButton!

    /// 点击右上角Butt响应
    @IBAction private func clickItembutt(_ sender: UIButton) {
        //可编辑的类型
        if itemMD?.itemStaue != ItemStaue_None || itemMD?.itemStaue != ItemStaue_HadAdd {
            
            ///代理响应，不需要respondsToSelector判断，直接使用？
            self.delegate?.coutomeCollectionViewCell?(self, buttType: (itemMD?.itemTitle!)!)
            
            ///触发闭包
            clickEditClosure?(itemMD!)
        }
    }
    
    /// cell的itemMD属性Set方法
    var itemMD:Items?{
        didSet{
            //填充对应的数据
            self.itemLab.text   =   self.itemMD?.itemTitle
            self.itemImgV.image =   UIImage.init(named: (self.itemMD?.imageName)!)
            let itemStaue:ItemStaue = self.itemMD?.itemStaue ?? ItemStaue_None
            
            var itemButt_Img:UIImage?
            
            switch itemStaue {
            case ItemStaue_None:
                itemButt_Img    =   nil
            case ItemStaue_CanDelete:
                itemButt_Img    =   UIImage.init(named: "canDelete")
            case ItemStaue_CanAdd:
                itemButt_Img    =   UIImage.init(named: "canAdd")
            case ItemStaue_HadAdd:
                itemButt_Img    =   UIImage.init(named: "hadAdd")
            default:
                itemButt_Img    =   nil
            }
            
            if itemButt_Img == nil {
                self.itemButt.isHidden  =   true
            }else{
                self.itemButt.isHidden  =   false
                self.itemButt.setBackgroundImage(itemButt_Img, for: UIControlState.normal)
            }
        }
    }
    
    /// 类方法，获取单元格
    ///
    /// - Parameters:
    ///   - collectionView: UICollectionView
    ///   - indexPath: IndexPath
    /// - Returns: CoutomeCollectionViewCell
    class func getCoutomeCollectionViewCell(collectionView:UICollectionView,indexPath:IndexPath) ->  CoutomeCollectionViewCell{
        
        let cell:CoutomeCollectionViewCell = (collectionView.dequeueReusableCell(withReuseIdentifier: CoutomeCollectionViewCell.className, for: indexPath) as! CoutomeCollectionViewCell)
        
        cell.contentView.backgroundColor   =   UIColor.white
        
        return  cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //增加按钮热度
        let  tap = UITapGestureRecognizer.init(target: self, action: #selector(clickItembutt(_:)))
        buttView.addGestureRecognizer(tap)
    }
    
    
}
