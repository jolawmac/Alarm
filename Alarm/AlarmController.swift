//
//  AlarmController.swift
//  Alarm
//
//  Created by Josh & Erica on 2/6/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import Foundation

class AlarmController {
    
    var alarms: [Alarm] = []
    
    static let shared = AlarmController()
    
    
    func addAlarm(fireTimeFromMidnight: TimeInterval, name: String) {
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        alarms.append(alarm)
    }
    
    func delete(alarm: Alarm) {
        if let index = alarms.index(of: alarm) {
            alarms.remove(at: index)
        }
    }
    
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
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
