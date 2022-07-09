//
//  HourOperationViewVM.swift
//  Test070422
//
//  Created by Admin on 09/07/2022.
//

import Foundation

struct HourOperationViewVM {
    var day: String {
        return WeekdayHelper.weekdaySymbol(day: hourOperation.day) ?? ""
    }
    
    var start: String {
        return formattedHour(hourOperation.start ?? "")
    }
    
    var end: String {
        formattedHour(hourOperation.end ?? "")
    }
    
    var isOvernight: Bool {
        return hourOperation.isOvernight
    }
    
    private let hourOperation: BusinessDetailModel.HourOperation
    
    init(hourOperation: BusinessDetailModel.HourOperation) {
        self.hourOperation = hourOperation
    }
    
    private func formattedHour(_ hour: String) -> String {
        guard hour.count > 2 else { return hour }
        
        var result = hour
        result.insert(":", at: result.index(result.startIndex, offsetBy: 2))
        return result
    }
}
