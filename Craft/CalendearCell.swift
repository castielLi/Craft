//
//  CalendearCell.swift
//  Craft
//
//  Created by castiel on 16/1/26.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class CalendearCell: UICollectionViewCell {
    
    var contentLabel : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentLabel = UILabel()
        contentLabel!.frame = self.bounds
        contentLabel!.textAlignment = .Center
        contentLabel!.backgroundColor = UIColor.clearColor()
        contentLabel!.textColor = UIColor.whiteColor()
        contentLabel!.layer.cornerRadius = UIAdapter.shared.transferWidth(2)
        contentLabel!.layer.borderWidth = 1
        contentLabel!.layer.borderColor = Resources.Color.goldenEdge.CGColor
        contentLabel!.layer.masksToBounds = true
        self.addSubview(contentLabel!)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
