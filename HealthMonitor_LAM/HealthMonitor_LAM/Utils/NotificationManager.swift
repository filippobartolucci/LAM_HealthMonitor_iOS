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
    func sendDailyNotification(d: Date) -> (){
        
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
    
    
    func checkMonitoringNotifications(monitoring: FetchedResults<Monitoring>, rs : FetchedResults<Report>) -> (){
        if rs.isEmpty || monitoring.isEmpty{
            if rs.isEmpty{
                print("no reports")
            }else{
                print("no monitoring")
            }
            return
        }
        print("Checking monitoring...")
        
        for m in monitoring{
            if !compareDate(date1: m.day ?? Date(), date2: Date()){
                m.day = Date()
                m.daysLeft -= 1
                if (m.daysLeft < 1){
                    let avgV = avgMonitoringValue(m: m, rs: rs)
                    
                    if (avgV == 0){
                        return
                    }
                    
                    if avgV <= m.limit {
                        self.sendOKMonitoringNotifications(value: m.value!, limit: m.limit, avg: avgV)
                    }else{
                        self.sendNotOKMonitoringNotifications(value: m.value!, limit: m.limit, avg: avgV)
                    }
                }
            }
        }
    }
    
    func sendOKMonitoringNotifications(value: String, limit: Float, avg: Float) -> (){
        self.center.removeAllPendingNotificationRequests()
        
        // Content
        let content = UNMutableNotificationContent()
        content.title = "Congratulations!"
        content.body = "Your avg. \(value) was \(avg), below the limit of \(limit)"
        content.sound = UNNotificationSound.default
        
        
        // Enable
        print("Creating new notification")
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        self.center.add(request) { error in
            guard error == nil else {
                print("Error occurred!")
                return
            }
            print("Notification scheduled!")
        }
    }
    
    private func sendNotOKMonitoringNotifications(value: String, limit: Float, avg: Float) -> (){
        self.center.removeAllPendingNotificationRequests()
        // Content
        
        let content = UNMutableNotificationContent()
        content.title = "Something went wrong..."
        content.body = "Your avg. \(value) was \(avg),over the limit of \(limit)"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.hour = 18  
           
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: false)
        // Enable
        print("Creating new notification")
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        self.center.add(request) { error in
            guard error == nil else {
                print("Error occurred!")
                return
            }
            print("Notification scheduled!")
        }
    }
    
    // Delete all pending notifications
    func removePendingNotification(){
        self.center.removeAllPendingNotificationRequests()
    }
    
}
