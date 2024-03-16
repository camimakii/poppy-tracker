//
//  DateUtils.swift
//  PoppyTracker
//
//  Created by Camille on 16/3/24.
//

import Foundation

let calendar = Calendar.current

func getDays(month : Int, year : Int) -> [DateContainer] {
    var dates: [DateContainer] = []

    var components = DateComponents()
    components.year = year
    components.month = month

    let firstDayOfMonth = calendar.date(from: components)

    let range = calendar.range(of: .day, in: .month, for: firstDayOfMonth!)

    for day in (range!) {
        var newComponents = DateComponents()
        newComponents.year = year
        newComponents.month = month
        newComponents.day = day
        let newDate = calendar.date(from: newComponents)
        dates.append(DateContainer(isFilled: true, date: newDate))
    }

    return fillUpMonthToStartOnMonday(monthDays: dates)
}

func fillUpMonthToStartOnMonday(monthDays dates : [DateContainer]) -> [DateContainer] {
    var newDatesArray : [DateContainer] = []

    var times = 0

    switch dates[0].dayOfWeek {
    case .tuesday:
        times = 1
    case .wednesday:
        times = 2
    case .thursday:
        times = 3
    case .friday:
        times = 4
    case .saturday:
        times = 5
    case .sunday:
        times = 6
    default:
        return dates
    }

    for _ in 1...times {
        newDatesArray.append(DateContainer(isFilled: false))
    }

    newDatesArray.append(contentsOf: dates)
    return newDatesArray
}
