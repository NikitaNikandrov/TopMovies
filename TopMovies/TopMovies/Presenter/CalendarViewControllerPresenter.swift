//
//  CalendarViewController.swift
//  TopMovies
//
//  Created by Никита on 05.04.2021.
//

import Foundation

protocol CalendarViewControllerProtocol: AnyObject {
    var movieNameForNotification: String? { get set }
    var dateOfNotification: DateComponents? { get set }
    func fetchChangesFromDatepicker()
}

class CalendarViewControllerPresenter {
    
    private let userNotification = UserNotifications()
    weak var delegate: CalendarViewControllerProtocol?
    
    func setNotification(){
        guard let body = delegate?.movieNameForNotification else { return }
        guard let date = delegate?.dateOfNotification else { return }
        self.userNotification.scheduleNotification(notificationBody: body, date: date)
    }
}
