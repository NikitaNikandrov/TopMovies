//
//  Notifications.swift
//  TopMovies
//
//  Created by Никита on 04.04.2021.
//

import Foundation
import UIKit
import UserNotifications


class UserNotifications: NSObject {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func notificationRequest() {
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: options) { (didAllow, error) in
            guard didAllow else { return }
            self.notificationCenter.getNotificationSettings { (settings) in
                guard settings.authorizationStatus == .authorized else { return }
            }
        }
    }
    
    func scheduleNotification(notificationBody: String, date: DateComponents) {
        
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "Don't forget to see the movie:"
        content.body = notificationBody
        content.sound = UNNotificationSound.default

        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        center.add(request) { (error) in
            print(error.debugDescription)
        }
    }
}

extension UserNotifications: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .banner, .sound])
    }
}
