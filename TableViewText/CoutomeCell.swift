//
//  CoutomeCell.swift
//  TableViewText
//
//  Created by thinkjoy on 2017/7/10.
//  Copyright © 2017年 杜瑞胜. All rights reserved.
//

import UIKit

class CoutomeCell: UITableViewCell {
    @IBOutlet weak private var titleLab: UILabel!

    var titStr:String?{
        didSet{
            print(titStr!)
            self.titleLab.text  =   titStr
        }
    }
    
    class func getCoutomeCell(tableV:UITableView) -> CoutomeCell! {
        
        var cell:CoutomeCell? = tableV.dequeueReusableCell(withIdentifier: CoutomeCell.className) as? CoutomeCell
        if cell==nil {
            
            //注册cell
            tableV.register(UINib.init(nibName: CoutomeCell.className, bundle: nil), forCellReuseIdentifier: CoutomeCell.className)
            
            cell    =   Bundle.main.loadNibNamed(CoutomeCell.className, owner: nil, options: nil)?.first as? CoutomeCell
        }
        
        cell?.selectionStyle    =   UITableViewCellSelectionStyle.none
        return cell!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        
//    }
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        
//    }
}
