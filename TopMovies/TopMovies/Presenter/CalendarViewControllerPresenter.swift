//
//  CalendarViewController.swift
//  TopMovies
//
//  Created by Никита on 05.04.2021.
//

import Foundation

class CalendarViewControllerPresenter {
    
    private let userNotification = UserNotifications()
    
    func setNotification(){
        guard let body = CalendarViewControllerData.shared.movieNameForNotification else { return }
        let date = CalendarViewControllerData.shared.dateOfNotification
        userNotification.scheduleNotification(notificationBody: body, date: date)
        print("notification setted")
    }
}
