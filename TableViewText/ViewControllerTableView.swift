//
//  ViewControllerTableView.swift
//  TableViewText
//
//  Created by thinkjoy on 2017/7/7.
//  Copyright © 2017年 杜瑞胜. All rights reserved.
//

import UIKit



class ViewControllerTableView: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var mainTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.tableHeaderView   =   UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0.1, height: 0.1))
        
        mainTableView.sectionFooterHeight   =   0.001
        mainTableView.sectionHeaderHeight   =   20
        
        self.automaticallyAdjustsScrollViewInsets   =   false//;true
        
        //rightBarButtonItem
        let button = UIButton.init(type: UIButtonType.custom)
        button.titleLabel?.font =   UIFont.systemFont(ofSize: 15)
        button.setTitle("编辑", for: UIControlState.normal)
        button.setTitle("完成", for: UIControlState.selected)
        button.sizeToFit()
        button.setTitleColor(UIColor.purple, for: UIControlState.normal)
        button.addTarget(self, action: #selector(clickEdit(butt:)), for: UIControlEvents.touchUpInside)
        self.navigationItem.rightBarButtonItem  =   UIBarButtonItem.init(customView: button)
        
    }

    @objc private func clickEdit(butt:UIButton) {
        butt.isSelected =   !butt.isSelected
        mainTableView.setEditing(!self.mainTableView.isEditing, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: -   UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return  self.dataAry.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cellAry:NSMutableArray = self.dataAry[section] as! NSMutableArray
        
        return  cellAry.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CoutomeCell = CoutomeCell.getCoutomeCell(tableV: tableView)
            
        let cellAry:NSMutableArray = self.dataAry[indexPath.section] as! NSMutableArray
        let str = cellAry[indexPath.row] as! String
//        cell.titleLab.text    =   "\(indexPath.section)区-\(str)行"
        cell.titStr =   "\(indexPath.section)区-\(str)行"
        
        return  cell
        
    }
    
//MARK: -   UITableViewDelegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let str:String = "区"+"\(section)"
        let lab = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 20))
        lab.text    =   str
        
        print("\(CoutomeCell.className)---\(String.init(describing: type(of: CoutomeCell())).components(separatedBy: ".").last!)")
        
        return  lab;
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
//MARK:     -   delete || insert
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle{
        
        let sectionMuAry =   self.dataAry[indexPath.section] as! NSMutableArray
        
        if indexPath.row<sectionMuAry.count/2 {
            return UITableViewCellEditingStyle.delete
        }else{
            return  UITableViewCellEditingStyle.insert
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let sectionMuAry =   self.dataAry[indexPath.section] as! NSMutableArray
            
            if sectionMuAry.count==1 {
                self.dataAry.removeObject(at: indexPath.section)
                
                self.mainTableView.deleteSections(NSIndexSet(index:indexPath.section) as IndexSet, with: UITableViewRowAnimation.left)
            }else{
                sectionMuAry.removeObject(at: indexPath.row)
                self.dataAry.replaceObject(at: indexPath.section, with: sectionMuAry)
                self.mainTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.left)
            }
        }else if editingStyle==UITableViewCellEditingStyle.insert{
            let sectionMuAry =   self.dataAry[indexPath.section] as! NSMutableArray
            
            sectionMuAry.insert("插入", at: indexPath.row)
            self.dataAry.replaceObject(at: indexPath.section, with: sectionMuAry)
            
            self.mainTableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.right)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?{
        return "删除"
    }
    
//MARK:     -   Move
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        if sourceIndexPath != destinationIndexPath {
            let moveMuAry =   self.dataAry[sourceIndexPath.section] as! NSMutableArray
            let str = moveMuAry[sourceIndexPath.row] as! String
            
            let toMoveMuAry = self.dataAry[destinationIndexPath.section] as! NSMutableArray;
            
            if destinationIndexPath.row>toMoveMuAry.count {
                toMoveMuAry.add(str)
            }else{
                toMoveMuAry.insert(str, at: destinationIndexPath.row)
            }
            
            if moveMuAry.count==1 {
                self.dataAry.removeObject(at: sourceIndexPath.section)
                
            }else{
                moveMuAry.removeObject(at: sourceIndexPath.row)
            }
            
        }
        
    }

//MARK:  -   Lazy 数据
    lazy var  dataAry = { () -> NSMutableArray in
        
        var muAry   =   NSMutableArray.init()
        let section = 2
        let row = 10
        
        for _ in 1...section {
            
            let cellAry = NSMutableArray.init()
            
            for j in 1...row {
                cellAry.add("\(j)")
            }
            muAry.add(cellAry)
        }
        
        return  muAry
    }()
}
