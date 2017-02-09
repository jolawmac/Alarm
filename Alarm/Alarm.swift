//
//  Alarm.swift
//  Alarm
//
//  Created by Josh & Erica on 2/6/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import Foundation


class Alarm: NSObject, NSCoding {
    
    private let fireTimeKey = "fireTime"
    private let nameKey = "name"
    private let enabledKey = "enabled"
    private let UUIDKey = "UUID"
    
    var fireTime: TimeInterval
    var name: String
    var enabled: Bool
    let uuid: String
    
    init(fireTime: TimeInterval, name: String, enabled: Bool = true, uuid: String = UUID().uuidString) {
        self.fireTime = fireTime
        self.name = name
        self.enabled = enabled
        self.uuid = uuid
    }
    
    
    // Given to us:
    
    var fireDate: Date? {
        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else { return nil }
        let fireDateFromThisMorning = Date(timeInterval: fireTime, since: thisMorningAtMidnight as Date)
        return fireDateFromThisMorning
    }
    
    var fireTimeAsString: String {
        let fireTime = Int(self.fireTime)
        var hours = fireTime/60/60
        let minutes = (fireTime - (hours*60*60))/60
        if hours >= 13 {
            return String(format: "%2d:%02d PM", arguments: [hours - 12, minutes])
        } else if hours >= 12 {
            return String(format: "%2d:%02d PM", arguments: [hours, minutes])
        } else {
            if hours == 0 {
                hours = 12
            }
            return String(format: "%2d:%02d AM", arguments: [hours, minutes])
        }
    }
    
    
    // Failable int: 
    
    required init?(coder aDecoder: NSCoder) {
        
        guard let name = aDecoder.decodeObject(forKey: nameKey) as? String,
            let uuid = aDecoder.decodeObject(forKey: UUIDKey) as? String else { return nil }
        
        self.fireTime = TimeInterval(aDecoder.decodeDouble(forKey: fireTimeKey))
        self.name = name
        self.enabled = aDecoder.decodeBool(forKey: enabledKey)
        self.uuid = uuid
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(fireTime, forKey: fireTimeKey)
        aCoder.encode(name, forKey: nameKey)
        aCoder.encode(enabled, forKey: enabledKey)
        aCoder.encode(uuid, forKey: UUIDKey)
    }
    
}

// Equatable outside the class

func ==(lhs: Alarm, rhs: Alarm) -> Bool {
    return lhs.uuid == rhs.uuid
}
