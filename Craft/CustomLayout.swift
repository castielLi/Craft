//
//  CustomLayout.swift
//  Craft
//
//  Created by castiel on 16/1/17.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class CustomLayout: UICollectionViewLayout {
    
    //内容区域总大小，不是可见区域
    override func collectionViewContentSize() -> CGSize {
        return CGSizeMake(collectionView!.bounds.size.width, CGFloat(collectionView!.bounds.size.height) + UIAdapter.shared.transferHeight(10))
    }
    
    //所有单元格位置属性
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesArray = [UICollectionViewLayoutAttributes]()
        let cellCount = self.collectionView!.numberOfItemsInSection(0)
        
        for i in 0..<cellCount{
            let indexPath = NSIndexPath(forItem: i, inSection: 0)
            
            let attributes = self.layoutAttributesForItemAtIndexPath(indexPath)
            
            attributesArray.append(attributes!)
        }
        
        return attributesArray
    }
    
    //这个方法返回每个单元格的位置和大小
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        //当前单元格布局属性
        let attribute = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        
        //单元格外部空隙，简单起见，这些常量都在方法内部定义了，没有共享成员
        let lineSpacing = 5
        
        //单元格变长
        let cellSide:CGFloat = UIAdapter.shared.transferWidth(23)
        
        //内部间隙，左右5
        let insets = UIEdgeInsetsMake(2, 5, 2, 5)
        
        //当前行数
        let line:Int = indexPath.item / 7
        
        //当前行的Y坐标
        let lineOriginY = cellSide * CGFloat(line) + CGFloat(lineSpacing * line) + insets.top
        
        //单元格x坐标
        
        //位置摆放
        if indexPath.item % 7 == 0{
            attribute.frame = CGRectMake(insets.left, lineOriginY, cellSide, cellSide)
        }else if indexPath.item % 7 == 1{
            attribute.frame = CGRectMake(insets.left * 2 + cellSide * 1, lineOriginY, cellSide, cellSide)
        }else if indexPath.item % 7 == 2{
            attribute.frame = CGRectMake(insets.left * 3 + cellSide * 2, lineOriginY, cellSide, cellSide)
        }else if indexPath.item % 7 == 3{
            attribute.frame = CGRectMake(insets.left * 4 + cellSide * 3, lineOriginY, cellSide, cellSide)
        }else if indexPath.item % 7 == 4{
            attribute.frame = CGRectMake(insets.left * 5 + cellSide * 4, lineOriginY, cellSide, cellSide)
        }else if indexPath.item % 7 == 5{
            attribute.frame = CGRectMake(insets.left * 6 + cellSide * 5, lineOriginY, cellSide, cellSide)
        }else if indexPath.item % 7 == 6{
            attribute.frame = CGRectMake(insets.left * 7 + cellSide * 6, lineOriginY, cellSide, cellSide)
        }
        
        return attribute
    }
    
}
