//
//  CollectionReusableHeaderView.swift
//  TableViewText
//
//  Created by thinkjoy on 2017/7/25.
//  Copyright © 2017年 杜瑞胜. All rights reserved.
//

import UIKit

class CollectionReusableHeaderView: UICollectionReusableView {
    
    private var typeLab:UILabel!
    
    var title:String? {
        didSet{
            typeLab.text    =   title ?? ""
        }
    }
    
    override init(frame: CGRect)  {
        super.init(frame: frame)
        
        typeLab = UILabel.init(frame: CGRect.init(x: 10, y: 0, width: frame.size.width-20, height: 35))
        typeLab.font    =   UIFont.systemFont(ofSize: 16)
        typeLab.textColor   =   UIColor.purple
        
        self.addSubview(typeLab)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
