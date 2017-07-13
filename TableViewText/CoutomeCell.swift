//
//  CoutomeCell.swift
//  TableViewText
//
//  Created by thinkjoy on 2017/7/10.
//  Copyright © 2017年 杜瑞胜. All rights reserved.
//

import UIKit

struct temper {
    var t:Double?
    var t1:Double?
    
    init(fromT tt:Double) {
        t = tt+1
    }
    
    init() {
        t1  =   23
    }
    
}


class CoutomeCell: UITableViewCell {
    @IBOutlet weak private var titleLab: UILabel!

    var titStr:String?{
        didSet{
            print(titStr!)
            self.titleLab.text  =   titStr
        }
    }
    
    static var kkkk:Int    =   0;
    
    /*CauseInput_BaseMessageInput_WeiFaXingWeiMegCell   * cell  =   [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
     if (!cell) {
     cell    =   [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
     cell.selectionStyle =   UITableViewCellSelectionStyleNone;
     }
     cell.contentView.backgroundColor    =   [UIColor colorWithCSS:Project_WhiteBg_Color];
     return cell;*/
    class func getCoutomeCell(tableV:UITableView) -> CoutomeCell! {
        
        
        var cell:CoutomeCell? = tableV.dequeueReusableCell(withIdentifier: CoutomeCell.className) as? CoutomeCell
        if cell==nil {
            
            tableV.register(UINib.init(nibName: CoutomeCell.className, bundle: nil), forCellReuseIdentifier: CoutomeCell.className)
            
            cell    =   Bundle.main.loadNibNamed(CoutomeCell.className, owner: nil, options: nil)?.first as? CoutomeCell
            
            cell?.selectionStyle    =   UITableViewCellSelectionStyle.none
            print("创建\(kkkk)")
            kkkk+=1
        }
        return cell!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        print("\(temper.init(fromT: 2))")
        print("\(String(describing: temper().t1))")

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
