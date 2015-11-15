//
//  ChooseSideCollectionCell.swift
//  Craft
//
//  Created by castiel on 15/11/7.
//  Copyright © 2015年 castiel. All rights reserved.
//

import UIKit

class ChooseSideCollectionCell: UICollectionViewCell {
    
    var image : UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if !self.isEqual(nil){
            image = UIImageView(frame: CGRectMake(0,0, self.frame.width, self.frame.height))
            self.addSubview(image!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
