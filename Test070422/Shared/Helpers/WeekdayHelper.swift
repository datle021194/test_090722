//
//  WeekdayHelper.swift
//  Test070422
//
//  Created by Admin on 09/07/2022.
//

import Foundation

struct WeekdayHelper {
    private static let weekDayMapper = [0: "Mon", 1: "Tue", 2: "Wed", 3: "Thur", 4: "Fri", 5: "Sat", 6: "Sun"]
    
    static func weekdaySymbol(day: Int) -> String? {
        return weekDayMapper[day]
    }
}
