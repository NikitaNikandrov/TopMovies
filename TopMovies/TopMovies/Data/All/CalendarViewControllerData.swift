//
//  CalendarViewControllerData.swift
//  TopMovies
//
//  Created by Никита on 03.07.2021.
//

import Foundation

final class CalendarViewControllerData {
    static var shared = CalendarViewControllerData()
    private init() {
        movieNameForNotification = nil
    }
    var movieNameForNotification: String?
    var dateOfNotification = DateComponents()
}
