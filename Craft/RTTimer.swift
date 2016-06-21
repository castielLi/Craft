//
//  RTTimer.swift
//  RTKit
//
//  Created by Rex Tsao on 8/4/2016.
//  Copyright © 2016 rexcao.net. All rights reserved.
//

import Foundation

class RTTimer {
    
    /// Get the timestamp since 1970.
    class func time() -> Int {
        let date = NSDate()
        
        // You need not set timezone here, because 1970 and current time are both use UTC time.
        let seconds = date.timeIntervalSince1970;
        return Int(seconds)
    }
    
    /// Get a time string with specific format from unix time.
    ///
    /// - parameter format The format you want to use.
    /// - parameter interval The unix time which will be formatted.
    class func formatUnixTime(format: String, interval: Int) -> String {
        let date = NSDate(timeIntervalSince1970: NSTimeInterval(interval))
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.stringFromDate(date)
    }
    
    /// Format a given date(NSDate) to string via your format.
    ///
    /// - parameter date: The date you want to format.
    /// - parameter format: Format.
    /// - parameter timeZone: The time zone you want to used for.
    class func formatDate(date: NSDate, format: String, timeZone: String = "Asia/Shanghai") -> String {
        let timeZone = NSTimeZone(name: timeZone)
        let fmt = NSDateFormatter()
        fmt.dateFormat = format
        fmt.timeZone = timeZone
        return fmt.stringFromDate(date)
    }
    
    
    /// Format time string to unix time stamp.
    ///
    /// - parameter timeStr: Time string.
    /// - parameter format: The format of the time string.
    /// - parameter timeZone: The time zone will be used for this parser.
    class  func toUnixTime(timeStr: String, format: String, timeZone: String = "Asia/Shanghai") -> NSTimeInterval {
        let fmt = NSDateFormatter()
        fmt.dateFormat = format
        let timeZone = NSTimeZone(name: timeZone)
        fmt.timeZone = timeZone
        let date = fmt.dateFromString(timeStr)!
        return date.timeIntervalSince1970
    }
}

// Extend DateProc to add Chinese Lunar processing
extension RTTimer {
    class ChineseLunar {
        private static let lunarNumber = ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十"]
        
        /// Lunar date of today.
        class func lunarDate() -> String {
            let fmt = NSDateFormatter()
            fmt.locale = NSLocale(localeIdentifier: "zh_CN")
            fmt.dateStyle = NSDateFormatterStyle.MediumStyle
            
            let chineseCal = NSCalendar(calendarIdentifier: NSCalendarIdentifierChinese)
            fmt.calendar = chineseCal
            fmt.dateFormat = "MMMdd"
            let date = fmt.stringFromDate(NSDate())
            return date
        }
        
        /// Lunar date of specific day.
        class func lunarDate(date: NSDate) -> String {
            let fmt = NSDateFormatter()
            fmt.locale = NSLocale(localeIdentifier: "zh_CN")
            fmt.dateStyle = NSDateFormatterStyle.MediumStyle
            
            let chineseCal = NSCalendar(calendarIdentifier: NSCalendarIdentifierChinese)
            fmt.calendar = chineseCal
            fmt.dateFormat = "MMMdd"
            let date = fmt.stringFromDate(date)
            return date
        }
        
        /// Parse short date to lunar date, here, the shor date should like "09-11", or you can use
        /// another character to join month and day, for example: 09月11
        class func monthToLunar(shortDate: String, joinCharacter: String = "-") -> String {
            let tmp = shortDate.componentsSeparatedByString(joinCharacter)
            let res = RTTimer.ChineseLunar.monthToLunar(Int(tmp[0])!) + RTTimer.ChineseLunar.dayToLunar(Int(tmp[1])!)
            return res
        }
        
        /// Turn day number to Chinese Lunar day.
        class func dayToLunar(day: Int) -> String {
            var res = "err"
            if day <= 10 {
                res = "初"+self.lunarNumber[day-1]
            } else if day > 10 && day <= 20 {
                if day == 20 {
                    res = "二十"
                } else {
                    let m = day % 10
                    res = "十"+self.lunarNumber[m-1]
                }
            } else if day > 20 && day < 30 {
                let m = day % 20
                res = "廿"+self.lunarNumber[m-1]
            } else {
                if day == 30 {
                    res = "三十"
                } else {
                    let m = day % 30
                    res = "三十"+self.lunarNumber[m-1]
                }
            }
            return res
        }
        
        /// Turn month number to Chinese Lunar month.
        class func monthToLunar(month: Int) -> String {
            var res = "err"
            if month == 1 {
                res = "正"
            } else if month == 12 {
                res = "腊"
            } else if month == 11 {
                res = "十一"
            } else {
                res = self.lunarNumber[month-1]
            }
            res = res+"月"
            return res
        }
    }
}