//
//  SettingsView.swift
//  HealthMonitor_LAM
//
//  Created by Filippo Bartolucci on 13/08/2020.
//  Copyright © 2020 Filippo Bartolucci. All rights reserved.
//

import SwiftUI
import CoreData


struct SettingsView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    //MARK: - NotificationSettings
    @State var monitoredDays = 7
    @State var importance = 1
    var value = ["Temp","Weight","Heart Rate","Glycemia"]
    @State var pickerValue : Int = 0
    @State var limit = ""
    
    @State var notificationManager : LocalNotificationManager
    @State var reminderTime = Date()
    
    func createNewMonitoring(){
        let m = Monitoring(context: managedObjectContext)
        
        m.day = Date()
        m.limit = Float(self.limit)!
        m.importance = Int16(self.importance)
        m.value = self.value[self.pickerValue]
        m.numberOfDays = Int16(self.monitoredDays)
        
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
    
    
    
    var body: some View {
        ScrollView{
            Group{
                if self.notificationManager.notificationsEnabled{
                    Spacer()
                    
                    Section(header: HStack{Text("Daily Reminder");Spacer()}.frame(maxWidth : widthBound)){
                        //MARK: -Daily Reminder
                        Spacer()
                        
                        boxView(content: AnyView(
                            VStack{
                                NavigationLink(destination: FormView(content: AnyView(
                                    VStack{
                                        DatePicker("", selection: $reminderTime,displayedComponents: .hourAndMinute).labelsHidden().padding()
                                    }
                                )).padding(.horizontal)){
                                    HStack{
                                        Text("Time of reminder")
                                        Spacer()
                                        Image(systemName: "arrow.right")
                                    }.padding(.horizontal)
                                }
                            }.frame(minHeight:buttonHeight)
                        ))
                        
                        Button(action: {
                            self.notificationManager.sendDailyNotification(d: self.reminderTime)
                        }){
                            boxView(content: AnyView(
                                HStack{
                                    Text("Set daily reminder").accentColor(.red)
                                        .frame(minHeight: buttonHeight)
                                    Spacer()
                                }.padding(.horizontal)
                            ))
                        }.frame(minHeight: buttonHeight)
                    }
                    Divider().frame(maxWidth: widthBound).padding(.vertical)
                    
                    Section(header: HStack{Text("Monitor yourself");Spacer()}.frame(maxWidth : widthBound)){
                        
                        boxView(content: AnyView(
                            HStack{
                                Group{
                                    Text("Track a personal value of your choice. Set a threshold value that must not be exceeded by the average. Choose which reports to use based on their importance ")
                                }
                                
                            }.padding().frame(minWidth: widthBound,minHeight: rowHeight)
                        )).padding(.top)
                        
                        boxView(content: AnyView(
                            NavigationLink(destination: FormView(content: AnyView(
                                VStack{
                                    Form{
                                        TextField("Threshold", text: self.$limit)
                                            .keyboardType(.decimalPad)
                                    }
                                    Spacer()
                                }
                            ))){
                                HStack{
                                    Text("Threshold value: " + self.limit).multilineTextAlignment(.leading)
                                    Spacer()
                                    Image(systemName: "arrow.right")
                                }.frame(minHeight: buttonHeight).padding(.horizontal)
                                
                            }
                        ))
                        
                        boxView(content: AnyView(
                            Picker(selection: self.$pickerValue, label: Text("Monitored value:")) {
                                ForEach(0..<self.value.count){
                                    Text(self.value[$0])
                                }
                            }.pickerStyle(SegmentedPickerStyle()).frame(minHeight:buttonHeight).padding(.horizontal)
                        ))
                        
                        boxView(content: AnyView(
                            Stepper("Days to monitor: " + String(self.monitoredDays), value: self.$monitoredDays, in: 1...31).padding().frame(maxHeight:buttonHeight)
                        ))
                        
                        boxView(content: AnyView(
                            Stepper("Importance: " + String(self.importance), value: self.$importance, in: 1...5).padding().frame(maxHeight:buttonHeight)
                        ))
                        
                        Button(action: {
                            // CODE HERE
                        }){
                            boxView(content: AnyView(
                                HStack{
                                    Text("Enable monitoring").accentColor(.red)
                                        .frame(minHeight: buttonHeight)
                                    Spacer()
                                }.padding(.horizontal)
                            ))
                        }.frame(minHeight: buttonHeight).disabled(self.limit.count == 0 ? true : false)
                    }
                    
                    Divider().frame(maxWidth: widthBound).padding(.vertical)
                    
                    Button(action: {
                        self.notificationManager.removePendingNotification()
                        self.
                    }){
                        boxView(content: AnyView(
                            HStack{
                                Text("Disable all notifications").accentColor(.red)
                                    .frame(minHeight: buttonHeight)
                                Spacer()
                            }.padding(.horizontal)
                        ))
                    }.frame(minHeight: buttonHeight)
                    Spacer()
                    
                }else{
                    //MARK: -Notifications not enabled
                    Spacer()
                    Button(action: {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                    }){
                        boxView(content: AnyView(
                            Text("Enable iOS Notification from settings").frame(minHeight:buttonHeight)
                        )).frame(minHeight:buttonHeight)
                    }
                    
                }
            }
        }.accentColor(Color("text")).navigationBarTitle("Settings")
    }
}

