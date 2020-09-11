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
    
    // check all Monitoring objects to see if it's time to send a notification
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
            // check to see if the last modified date of the report is different from today
            if !compareDate(date1: m.day ?? Date(), date2: Date()){
                // Days between last update and today
                m.daysLeft -= Int16(daysBetween(firstDate: m.day!, secondDate: Date()))
                // Date updating
                m.day = Date()
                if (m.daysLeft < 1){
                    let avgV = avgMonitoringValue(m: m, rs: rs)
                    if (avgV == 0){
                        return
                    }
                    // notification to send
                    self.sendMonitoringNotification(value: m.value!, limit: m.limit, avg: avgV, start: m.startDay!)
                }
            }
        }
    }
    
    func sendMonitoringNotification(value: String, limit: Float, avg: Float, start: Date) -> (){
        // Content
        let content = UNMutableNotificationContent()
        content.title = "Monitoring: " + start.stringify() + " - " + Date().stringify()
        content.body = "Avg. \(value) was \(avg), "
        if avg <= limit{
            content.body += "below the limit of \(limit)"
        }else{
            content.body += "over the limit of \(limit)"
        }
        
        content.sound = UNNotificationSound.default
        
        
        var dateComponents = DateComponents()
        dateComponents.hour = Calendar.current.component(.hour, from: Date())
        dateComponents.minute = Calendar.current.component(.minute, from: Date()) + 1
        
           
        // Create the trigger as a non repeating event.
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
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
