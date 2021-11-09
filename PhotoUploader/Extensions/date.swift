//
//  date.swift
//  Sony 360 RA
//
//  Created by Andrija Milovanovic on 7/8/21.
//

import Foundation

extension DateFormatter
{
    static var showTime: DateFormatter  {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm"
        formatter.timeZone = TimeZone.current;
        return formatter
    }
    static var durationFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:ss"
        formatter.timeZone = TimeZone.current;
        return formatter
    }
}

extension Date
{
    var timeMili: Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    public static var time:Int64 {
        return Int64(Date().timeIntervalSince1970)
    }
    init(interval:Int64) {
         self = Date(timeIntervalSince1970: TimeInterval(interval))
    }
    init(ms:Int64) {
         self = Date(timeIntervalSince1970: TimeInterval(ms/1000))
    }
}

extension Float {
    
    var time:String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: TimeInterval(self)) ?? ""
    }
}

extension Double {

    var time:String {
        return Float(self).time
    }
}

