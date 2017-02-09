//
//  AlarmController.swift
//  Alarm
//
//  Created by Josh & Erica on 2/6/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import Foundation

import UserNotifications
import UIKit



class AlarmController {
    
    // Singleton
    static let shared = AlarmController()
    
    
    // Array
    var alarms: [Alarm] = []
    init() {
        loadFromPersistentStorage()
    }
    
    
    // CRUD 
    
    func addAlarm(fireTimeFromMidnight: TimeInterval, name: String) -> Alarm {
        let alarm = Alarm(fireTime: fireTimeFromMidnight, name: name)
        alarms.append(alarm)
        saveToPersistentStorage()
        return alarm
    }
    
    func update(alarm: Alarm, fireTime: TimeInterval, name: String) {
        alarm.fireTime = fireTime
        alarm.name = name
        saveToPersistentStorage()
    }
    
    func delete(alarm: Alarm) {
        if let index = alarms.index(of: alarm) {
            alarms.remove(at: index)
        }
        saveToPersistentStorage()
    }
    
    func toggleEnabled(alarm: Alarm) {
        if alarm.enabled {
            alarm.enabled = false
        } else {
            alarm.enabled = true
        }
        saveToPersistentStorage()
    }
    
    
    
    func saveToPersistentStorage() {
        guard let indexPath = AlarmController.persistentAlarmsFilePath else { return }
        NSKeyedArchiver.archiveRootObject(self.alarms, toFile: indexPath)
    }
    
    func loadFromPersistentStorage() {
        guard let indexPath = AlarmController.persistentAlarmsFilePath else { return }
        guard let alarms = NSKeyedUnarchiver.unarchiveObject(withFile: indexPath) as? [Alarm] else { return }
        self.alarms = alarms
    }
    
    static var persistentAlarmsFilePath: String? {
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        guard let documentsDirectory = directories.first as NSString? else { return nil }
        return documentsDirectory.appendingPathComponent("Alarms.plist")
    }
    
    
    // Mock Data: 
    
//    
//    init() {
//        let josh = Alarm(fireTimeFromMidnight: 25200, name: "Josh", enabled: true, uuid: "0001")
//        let morningRun = Alarm(fireTimeFromMidnight: 25200, name: "Morning Run", enabled: true, uuid: "0002")
//        
//        
//        alarms = [josh, morningRun]
//    }
    
    
}

protocol AlarmScheduler {
    func scheduleLocalNotification(_ alarm: Alarm)
    func cancelLocalNotification(_ alarm: Alarm)
}

extension AlarmScheduler {
    func scheduleLocalNotification(_ alarm: Alarm) {
        let localNotification = UILocalNotification()
        localNotification.userInfo = ["UUID" : alarm.uuid]
        localNotification.alertTitle = "Time's up!"
        localNotification.alertBody = "Your alarm titled \(alarm.name) is done"
        localNotification.fireDate = alarm.fireDate as Date?
        localNotification.repeatInterval = .day
        UIApplication.shared.scheduleLocalNotification(localNotification)
    }
    
    func cancelLocalNotification(_ alarm: Alarm) {
        guard let scheduledNotifications = UIApplication.shared.scheduledLocalNotifications else {return}
        for notification in scheduledNotifications {
            guard let uuid = notification.userInfo?["UUID"] as? String
                , uuid == alarm.uuid else { continue }
            UIApplication.shared.cancelLocalNotification(notification)
        }
}
}


