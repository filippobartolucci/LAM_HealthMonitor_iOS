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

class LocalNotificationManager: ObservableObject {
    var center = UNUserNotificationCenter.current()
    var notifications = [Notification]()
    var notificationsEnabled = false
    
    init(){
        self.center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil {
                print("Notifications permitted")
            } else {
                print("Notifications not permitted")
            }
        }
    }
    
    // Return true if notifications are permitted
    func checkPermission() -> Bool {
        var perm = false
        self.center.getNotificationSettings { (settings) in
            if(settings.authorizationStatus == .authorized) {
                print("Notifications enabled")
                perm = true
            } else {
                print("Notifications not enabled")
            }
        }
        return perm
    }
    
    // Return true if there are pending notifications
    func checkForPendingNotifications() -> Bool {
        var pending = true
        
        self.center.getPendingNotificationRequests(completionHandler: { requests in
            print("Checking pending notifications...")
            if requests.isEmpty == true {
                print("No pending notifications.")
                pending = false
            }
        })
        print(pending)
        return pending
    }
    
    // Set new notification
    func sendNotification() {
        
        // Disable old notifications
        self.removePendingNotification()
        
        // Content
        let content = UNMutableNotificationContent()
        content.title = "Daily Report"
        content.body = "Remember to add today report"
        content.sound = UNNotificationSound.default
        
        // Time
        var dateComponents = DateComponents()
        dateComponents.hour = 17
        dateComponents.minute = 23
        
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
