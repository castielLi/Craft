//
//  CalendarView.swift
//  Craft
//
//  Created by castiel on 16/1/17.
//  Copyright © 2016年 castiel. All rights reserved.
//

import UIKit

class CalendarView: UIView , UICollectionViewDataSource , UICollectionViewDelegate{
    
    var soundPlay :PlaySound?
    let cellWidth = (UIScreen.mainScreen().bounds.width - UIAdapter.shared.transferWidth(30) - 40)/7

    var collectionView: UICollectionView?
    
    var cellSelectedBlock : ((activities : NSArray)->Void)?
    var cellCancelSelectedBlock : ((activities : NSArray)->Void)?
    
    var cellData: [String] = ["日", "一", "二", "三", "四", "五", "六"]
    
    var year = 2016
    var month = 1
    var firstDay = 5
    var isLeapYear:Bool = true
    
    var nextButton : UIButton?
    

    
    var theLock = NSLock()
    var mark = 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        soundPlay = PlaySound.sharedData()
        createCellData()
        
        let layout = CustomLayout()
        
        self.collectionView = UICollectionView(frame: CGRectMake(UIAdapter.shared.transferWidth(60) , UIAdapter.shared.transferHeight(60) , self.frame.width - UIAdapter.shared.transferWidth(120), UIAdapter.shared.transferHeight(190) ), collectionViewLayout: layout)
        
        //注册CollectionViewCell
        collectionView!.registerClass(CalendearCell.self, forCellWithReuseIdentifier: "ViewCell")
        
        //collection背景颜色
        collectionView!.backgroundColor = UIColor.clearColor()
        collectionView!.showsVerticalScrollIndicator = false
        
        collectionView!.delegate = self
        collectionView!.dataSource = self
        
        self.addSubview(self.collectionView!)
        
        setNextButton()
    }
    
    func setNextButton(){
        self.nextButton = UIButton()
        self.nextButton!.setImage(UIImage(named: "nextpage"), forState: UIControlState.Normal)
        self.nextButton!.addTarget(self, action: "calculateNextFirstDay", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(self.nextButton!)
        
        self.nextButton!.mas_makeConstraints{ make in
           make.top.equalTo()(self.collectionView!.mas_bottom).with().offset()(UIAdapter.shared.transferHeight(7))
           make.width.equalTo()(UIAdapter.shared.transferWidth(100))
           make.height.equalTo()(UIAdapter.shared.transferHeight(27))
           make.centerX.equalTo()(self.collectionView!)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        
        if y > 20{
            dispatch(2.0, scrollMenu: 1)
        }else if y < -20{
            dispatch(2.0, scrollMenu: 0)
        }
        
    }
    
    /**
     线程 0向上 1向下
     */
    func dispatch(time:NSTimeInterval, scrollMenu:Int){
        let time: NSTimeInterval = time
        let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))

        if mark == 2{
            mark = scrollMenu
            if scrollMenu == 0{
                self.calculateBeforeFirstDay()
            }else if scrollMenu == 1{
                self.calculateNextFirstDay()
            }
            dispatch_after(delay, dispatch_get_main_queue(), { () -> Void in
               self.mark = 2
            })
        }
    }
    
    /**
     计算下个月的一号信息
     */
    func calculateNextFirstDay(){
        
        let soundId = soundPlay!.sound.valueForKey(SoundResource.clickEventSound) as! String
        let id = UInt32(soundId)
        AudioServicesPlaySystemSound(id!);
        
        var nextMonth:Int!
        var currentMonth:Int!
        var currentMotnDays:Int!
        var nextFirstDay:Int?
        
        currentMonth = month
        nextMonth = (month != 12) ? month + 1 : 1
        year = (month == 12) ? year + 1 : year
        
        switch currentMonth{
        case 1, 3, 5, 7, 8, 10, 12:
            currentMotnDays = 31
        case 4, 6, 9, 11:
            currentMotnDays = 30
        case 2:
            currentMotnDays = isLeapYear ? 29 : 28
        default: break
        }
        
        nextFirstDay = (firstDay + (currentMotnDays % 7)) % 7
        month = nextMonth
        firstDay = nextFirstDay!
        
        cellData.removeAll()
        cellData += ["日", "一", "二", "三", "四", "五", "六"]
        
        createCellData()
        
        self.collectionView!.reloadData()
        print("这是\(currentMonth)月")
    }
    
    /**
     计算上个月的一号信息
     */
    func calculateBeforeFirstDay(){
        var beforeMonth:Int!
        var beforeMonthDays:Int!
        var beforeFirstDay:Int?
        
        //计算上个月和下个月的月份
        beforeMonth = (month != 1) ? (month - 1) : 12
        year = (month == 1) ? year - 1 : year
        
        switch beforeMonth{
        case 1, 3, 5, 7, 8, 10, 12:
            beforeMonthDays = 31
        case 4, 6, 9, 11:
            beforeMonthDays = 30
        case 2:
            beforeMonthDays = isLeapYear ? 29 : 28
        default: break
        }
        
        let surplusDays = (firstDay + (7 - (beforeMonthDays) % 7)) % 7
        beforeFirstDay = surplusDays > 0 ? surplusDays : -surplusDays
        month = beforeMonth
        firstDay = beforeFirstDay!
        
        cellData.removeAll()
        cellData += ["日", "一", "二", "三", "四", "五", "六"]
        
        createCellData()
        
        self.collectionView!.reloadData()
    }
    
    /**
     创建日期数组信息
     */
    func createCellData(){
        /**
        *  计算是否为闰年
        */
        if year % 100 == 0 && year % 400 == 0{
            isLeapYear = true
        }else if year % 4 == 0{
            isLeapYear = true
        }else {
            isLeapYear = false
        }
        
        /**
        *  根据每月第一日是周几 加入数组
        */
        switch firstDay{
        case 1: creatFirstDay(1)
        case 2: creatFirstDay(2)
        case 3: creatFirstDay(3)
        case 4: creatFirstDay(4)
        case 5: creatFirstDay(5)
        case 6: creatFirstDay(6)
        case 7: creatFirstDay(7)
        default: break
        }
        
        /**
        *  创建该月天数的数组信息
        */
        switch month{
        case 1, 3 ,5 ,7, 8, 10, 12:
            for i in 1...31{
                cellData.append("\(i)")
            }
        case 4, 6, 9 ,11:
            for i in 1...30{
                cellData.append("\(i)")
            }
        case 2:
            if isLeapYear == true{
                for i in 1...29{
                    cellData.append("\(i)")
                }
            }else{
                for i in 1...28{
                    cellData.append("\(i)")
                }
            }
        default: break
        }
        
    }
    
    /**
     计算1号是周几，进行数组添加
     
     - parameter firstDay: 1号是周几
     */
    func creatFirstDay(firstDay: Int){
        for _ in 1...firstDay{
            cellData.append("")
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identify:String = "ViewCell"
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(identify, forIndexPath: indexPath) as? CalendearCell
        
        
        if cell == nil{
             cell = CalendearCell(frame: CGRect(x: 0, y: 0, width: cellWidth, height: cellWidth))
        }
        
        cell!.normalLabel!.text = cellData[indexPath.item]
        cell!.normalLabel!.tag = indexPath.item + 1
        
        if cellData[indexPath.item] == "3" || cellData[indexPath.item] == "4"{
            cell!.iconImage!.hidden = false
        }else{
           cell!.iconImage!.hidden = true
        }

        cell!.backgroundColor = UIColor.clearColor()
        
        return cell!
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        
        self.cellSelectedBlock!(activities: NSArray())
        
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        
        
    }

    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
