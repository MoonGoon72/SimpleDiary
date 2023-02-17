//
//  MonthStruct.swift
//  SimpleDiary
//
//  Created by cnu on 2023/02/17.
//

import Foundation

struct MonthStruct {
    var monthType: MonthType
    var dayInt: Int
    func day() -> String {
        return String(dayInt)
    }
}

enum MonthType
{
    case Previous
    case Current
    case Next
}
