//
//  CoutomeCollectionViewCell.swift
//  TableViewText
//
//  Created by thinkjoy on 2017/7/11.
//  Copyright © 2017年 杜瑞胜. All rights reserved.
//

import UIKit

@objc protocol CoutomeCollectionViewCellDelegate : NSObjectProtocol{
    //public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    
    /// 可选代理
    @objc optional func coutomeCollectionViewCell(_ cell:CoutomeCollectionViewCell,buttType:String)
}

///  声明一个闭包别名，闭包含字符串类型的两个参数，无返回值(使用“（）”或者“Void”都一样)
typealias EditClosure = (_ editType:String) -> Void

class CoutomeCollectionViewCell: UICollectionViewCell {

    weak var delegate:CoutomeCollectionViewCellDelegate?
    
    /// 闭包声明
    private var clickEditClosure:EditClosure?
    
    /// 触发闭包调用方法，给外部外部调用
    func clickEditClosureFunction(closure:@escaping EditClosure) {
        clickEditClosure =   closure
    }
    
    @IBOutlet weak private var itemImgV: UIImageView!
    @IBOutlet weak private var itemLab: UILabel!
    
    @IBOutlet weak private var buttView: UIView!
    @IBOutlet weak private var itemButt: UIButton!

    
    let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
    func backward(_ s1: String, _ s2: String) -> Bool {
        return s1 > s2
    }
    
    var customersInLine = ["Barry", "Daniella"]
    
    @IBAction private func clickItembutt(_ sender: UIButton) {
        
        self.delegate?.coutomeCollectionViewCell?(self, buttType: titStr!)
        
        ///触发闭包
        clickEditClosure?(titStr!)
    }
    
    var titStr:String?{
        didSet{
            self.itemLab.text  =   titStr
            print(titStr!)
        }
    }
    
    class func getCoutomeCollectionViewCell(collectionView:UICollectionView,indexPath:IndexPath) ->  CoutomeCollectionViewCell{
        
        var cell:CoutomeCollectionViewCell? = (collectionView.dequeueReusableCell(withReuseIdentifier: CoutomeCollectionViewCell.className, for: indexPath) as? CoutomeCollectionViewCell)
        
        if cell==nil {
            
            cell    =   Bundle.main.loadNibNamed(CoutomeCollectionViewCell.className, owner: nil, options: nil)?.first as? CoutomeCollectionViewCell
        }
        cell?.contentView.backgroundColor   =   UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        
        return  cell!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
}
