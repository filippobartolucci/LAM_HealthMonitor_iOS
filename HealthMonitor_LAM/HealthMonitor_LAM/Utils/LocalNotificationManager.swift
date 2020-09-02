//
//  Notifications.swift
//  HealthMonitor_LAM
//
//  Created by Filippo Bartolucci on 16/08/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//
import Foundation
import SwiftUI
import NotificationCenter
import UserNotifications

class LocalNotificationManager: ObservableObject {
    var center = UNUserNotificationCenter.current()
    var notifications = [Notification]()
    var notificationsEnabled = false
    
    init(){
        self.center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil {
                print("Notifications permitted")
                self.notificationsEnabled = true
            } else {
                print("Notifications not permitted")
            }
        }
    }
    
    
    // Set new notification
    func sendDailyNotification(d: Date) {
        
        // Disable old notifications
        self.removePendingNotification()
        
        // Content
        let content = UNMutableNotificationContent()
        content.title = "Daily Report"
        content.body = "Remember to add today report"
        content.sound = UNNotificationSound.default
        
        // Time
        var dateComponents = DateComponents()
        dateComponents.hour = Calendar.current.component(.hour, from: d)
        dateComponents.minute = Calendar.current.component(.minute, from: d)
        
        // Enable
        print("Creating new notification")
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        self.center.add(request)
    }
    
    // Delete all pending notifications
    func removePendingNotification(){
        self.center.removeAllPendingNotificationRequests()
    }
    
}
