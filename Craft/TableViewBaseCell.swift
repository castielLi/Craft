//
//  TableViewBaseCell.swift
//  CowPlan
//
//  Created by castiel on 15/7/24.
//  Copyright (c) 2015年 novasoftware. All rights reserved.
//

import UIKit

class TableViewBaseCell: UITableViewCell {
    
    
    var topline : UILabel?
    var bottomline : UILabel?
    var type : CellType?
//    var selectedDelegate : PhoneTableProtocol?
    
    private var frameHeight : CGFloat = 0
    var cellHeight : CGFloat {
        get { return self.frameHeight }
        set {  self.frameHeight = newValue }
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String? , cellHeight : CGFloat) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.frameHeight = cellHeight
        topline = UILabel(frame: CGRectMake(0, 0, UIAdapter.shared.transferWidth( self.frame.width), 1))
        topline!.layer.borderColor = UIColor(red: 225 / 255, green: 225 / 255, blue: 225 / 255, alpha: 1).CGColor
        topline!.layer.borderWidth = 1
        self.addSubview(topline!)
        
        bottomline = UILabel(frame: CGRectMake(0, self.cellHeight - 1, UIAdapter.shared.transferWidth( self.frame.width), 1))
        bottomline!.layer.borderColor = UIColor(red: 225 / 255, green: 225 / 255, blue: 225 / 255, alpha: 1).CGColor
        bottomline!.layer.borderWidth = 1
        self.addSubview(bottomline!)
    }
    
    
    init(style: UITableViewCellStyle, reuseIdentifier: String? , cellHeight : CGFloat , lineColor : UIColor) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.frameHeight = cellHeight
        topline = UILabel(frame: CGRectMake(0, 0, UIAdapter.shared.transferWidth( self.frame.width), 1))
        topline!.layer.borderColor = lineColor.CGColor
        topline!.layer.borderWidth = 1
        self.addSubview(topline!)
        
        bottomline = UILabel(frame: CGRectMake(0, self.cellHeight - 1, UIAdapter.shared.transferWidth( self.frame.width), 1))
        bottomline!.layer.borderColor = lineColor.CGColor
        bottomline!.layer.borderWidth = 1
        self.addSubview(bottomline!)
    }

    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.cellHeight = self.frame.height
        topline = UILabel(frame: CGRectMake(0, 0, UIAdapter.shared.transferWidth( self.frame.width), 1))
        topline!.layer.borderColor = UIColor(red: 225 / 255, green: 225 / 255, blue: 225 / 255, alpha: 1).CGColor
        topline!.layer.borderWidth = 1
        self.addSubview(topline!)
        
        bottomline = UILabel(frame: CGRectMake(0, self.cellHeight - 1, UIAdapter.shared.transferWidth( self.frame.width), 1))
        bottomline!.layer.borderColor = UIColor(red: 225 / 255, green: 225 / 255, blue: 225 / 255, alpha: 1).CGColor
        bottomline!.layer.borderWidth = 1
        self.addSubview(bottomline!)
        
    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTopLineHide(){
       self.topline!.hidden = true
    }
    
    func setBottomLineHide(){
        self.bottomline!.hidden = true
    }
    
    func setBottomLineStyle(style : CellType){
        if style == CellType.LackLeftPart{
           self.bottomline!.layer.frame = CGRectMake(UIAdapter.shared.transferWidth(75), self.cellHeight - UIAdapter.shared.transferHeight(1), UIAdapter.shared.transferWidth( self.frame.width), UIAdapter.shared.transferHeight(1))
        }
    }
    
    func setTopLineStyle(style : CellType){
        if style == CellType.LackLeftPart{
            self.topline!.layer.frame = CGRectMake(UIAdapter.shared.transferWidth(75), 0, UIAdapter.shared.transferWidth( self.frame.width), UIAdapter.shared.transferHeight(1))
        }
    }



    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
