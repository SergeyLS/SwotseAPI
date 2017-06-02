//
//  DateManager.swift
//  SwotseAPI
//
//  Created by Sergey Leskov on 6/1/17.
//  Copyright © 2017 Sergey Leskov. All rights reserved.
//

import Foundation


class DateManager {
    //==================================================
    // MARK: - Stored Properties
    //==================================================
    static let dateNil = Date(timeIntervalSince1970: 0)
    
    
    static func dateToString(date: Date) -> String {
        
        return DateFormatter.localizedString(from: date, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none)
    }
    
    
    static func dateAndTimeToString(date: Date) -> String {
        
        return DateFormatter.localizedString(from: date, dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.medium)
    }
    
    
    //datefromString
    static func datefromString(string: String) -> Date {
        var date = Date()
        
        let dateFormatter = DateFormatter()
        
        //Tue, 11 Apr 2017 13:40:00 PDT
        //dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
        //http://userguide.icu-project.org/formatparse/datetime
        //https://docs.python.org/3/library/datetime.html#strftime-strptime-behavior
        
        //"%Y-%m-%dT%H:%M:%S.%fZ"
        //2017-06-01T17:05:12.077245Z
        
           dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'.'AZ"
        //print(string + " -> " + String(describing: dateFormatter.date(from: string)) )
        
        if let tempDate = dateFormatter.date(from: string) {
            date = tempDate
        }
        return date
    }

    
}
