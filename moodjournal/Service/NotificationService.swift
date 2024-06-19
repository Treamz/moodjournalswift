//
//  NotificationService.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 13.06.2024.
//

import Foundation

import UserNotifications

class NotificationService {
    static let shared = NotificationService()
    
    func requestNotification(completion: @escaping (Result<Bool, Error>) -> Void) {
        let options : UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                completion(.failure(error))
                print("ERROR \(error.localizedDescription)")
            } else {
                completion(.success(success))
                print("Success")
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        
        content.title = "Log your mood"
        content.body = "Better mood for you"
        content.sound = .default
        content.badge = 1
        
        // Time
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: true)
        
        // Calendar
        var dateComponents = DateComponents()
        dateComponents.hour = 12
        dateComponents.minute = 32
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Location
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}
