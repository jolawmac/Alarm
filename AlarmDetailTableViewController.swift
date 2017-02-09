//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Josh & Erica on 2/6/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController, AlarmScheduler {

    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alarmTitleTextField: UITextField!
    @IBOutlet weak var enableDisableButtonTapped: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

    var alarm: Alarm? {
    didSet {
        if isViewLoaded {
    updateViews()
        } else {
            loadView()
        }
        }
    }

    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = alarmTitleTextField.text,
            let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else { return }
        let timeIntervalSinceMidnight = datePicker.date.timeIntervalSince(thisMorningAtMidnight as Date)
        
        if let alarm = alarm {
            AlarmController.shared.update(alarm: alarm, fireTime: timeIntervalSinceMidnight, name: title)
            cancelLocalNotification(alarm)
            scheduleLocalNotification(alarm)
        } else {
            let alarm = AlarmController.shared.addAlarm(fireTimeFromMidnight: timeIntervalSinceMidnight, name: title)
            self.alarm = alarm
            scheduleLocalNotification(alarm)
        }
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func enableDisableButtonTapped(_ sender: Any) {
        guard let alarm = alarm else {return}
        AlarmController.shared.toggleEnabled(alarm: alarm)
        if alarm.enabled {
            scheduleLocalNotification(alarm)
        } else {
            cancelLocalNotification(alarm)
        }
        updateViews()
    }
        
    
    private func updateViews() {
        guard let alarm = alarm,
            let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight, isViewLoaded else {
                enableDisableButtonTapped.isHidden = true
                return
        }
        
        datePicker.setDate(Date(timeInterval: alarm.fireTime, since: thisMorningAtMidnight), animated: false)
        alarmTitleTextField.text = alarm.name
        
        enableDisableButtonTapped.isHidden = false
        if alarm.enabled {
            enableDisableButtonTapped.setTitle("Disable", for: UIControlState())
            enableDisableButtonTapped.setTitleColor(.white, for: UIControlState())
            enableDisableButtonTapped.backgroundColor = .red
        } else {
            enableDisableButtonTapped.setTitle("Enable", for: UIControlState())
            enableDisableButtonTapped.setTitleColor(.blue, for: UIControlState())
            enableDisableButtonTapped.backgroundColor = .gray
        }
        
        self.title = alarm.name
    }
}
