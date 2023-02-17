//
//  CalendarCell.swift
//  SimpleDiary
//
//  Created by cnu on 2023/02/17.
//

import SwiftUI

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
}

struct CalendarCell: View {
    @EnvironmentObject var dateHolder: DateHolder
    @ObservedObject var manager: DiaryDataManager = DiaryDataManager.shared
    let count: Int
    let startingSpaces: Int
    let daysInMonth: Int
    let daysInPrevMonth: Int
    
    
    var body: some View {
        ZStack {
            Text(monthStruct().day())
                .foregroundColor(textColor(type: monthStruct().monthType))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Rectangle().opacity(getKeyDate() == manager.today ? 0.1 : 0.0)
            
            Circle().opacity(getKeyDate() == manager.keyDate ? 0.1 : 0.0)
        }
        .onTapGesture {
            let KeyDate = getKeyDate()
            manager.strKeyDate = KeyDate
        }
    }
    
    func getKeyDate() -> String {
        var date = dateHolder.date
        switch monthStruct().monthType {
        case .Current: break;
        case .Next: date = CalendarHelper().plusMonth(date)
        case .Previous: date = CalendarHelper().minusMonth(date)
        }
        
        let components = date.get(.year, .day, .month)
        if let month = components.month, let year = components.year {
            return String(format: "%04d-%02d-%02d", year, month, monthStruct().dayInt)
        }
        
        return ""
    }
    
    func textColor(type:MonthType) -> Color {
        return type == MonthType.Current ? Color.black : Color.gray
    }
    
    func monthStruct() -> MonthStruct {
        let start = startingSpaces == 0 ? startingSpaces + 7 : startingSpaces
        
        if (count <= start) {
            let day = daysInPrevMonth + count - start
            return MonthStruct(monthType: .Previous, dayInt: day)
        }
        else if (count - start > daysInMonth) {
            let day = count - start - daysInMonth
            return MonthStruct(monthType: .Next, dayInt: day)
        }
        let day = count - start
        return MonthStruct(monthType: .Current, dayInt: day)
    }
}

struct CalendarCell_Previews: PreviewProvider {
    static var previews: some View {
        CalendarCell(count: 1, startingSpaces: 1, daysInMonth: 1, daysInPrevMonth: 1).environmentObject(DateHolder())
    }
}
