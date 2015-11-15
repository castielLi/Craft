//
//  ChooseSideCollectionSource.swift
//  Craft
//
//  Created by castiel on 15/11/7.
//  Copyright © 2015年 castiel. All rights reserved.
//

import Foundation

class ChooseSideCollectionSource : NSObject , UICollectionViewDataSource , UICollectionViewDelegate{
    
    
    var _itemsImages:[String]?
    var _onRowSelected:((Int)->Void)?
    
    override init() {
        super.init()
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self._itemsImages!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
            as! ChooseSideCollectionCell
        
        cell.image?.image = UIImage(named: self._itemsImages![indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if _onRowSelected != nil{
        self._onRowSelected!(indexPath.row)
        }
    }
    
    
    
}