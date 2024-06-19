//
//  SettingsViewModel.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 13.06.2024.
//
import UserNotifications
class SettingsViewModel : ObservableObject {
    @Published var isAuthorized: Bool = false
    init() {
            checkNotificationAuthorization()
    }
    
    
    func requestNotificationAuthorization() {
         let options: UNAuthorizationOptions = [.alert, .sound, .badge]
         UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
             DispatchQueue.main.async {
                 if let error = error {
                     print("ERROR \(error.localizedDescription)")
                 }
                 // Recheck the authorization after attempting to request permissions
                 self.checkNotificationAuthorization()
                 NotificationService.shared.scheduleNotification()
             }
         }
     }
     
    func checkNotificationAuthorization() {
          UNUserNotificationCenter.current().getNotificationSettings { settings in
              DispatchQueue.main.async {
                  self.isAuthorized = settings.authorizationStatus == .authorized
              }
          }
      }
}
