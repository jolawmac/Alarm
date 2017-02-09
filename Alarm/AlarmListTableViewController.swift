//
//  AlarmListTableViewController.swift
//  Alarm
//
//  Created by Josh & Erica on 2/6/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit


class AlarmListTableViewController: UITableViewController, SwitchTableViewCellDelegate, AlarmScheduler {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return AlarmController.shared.alarms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? SwitchTableViewCell else { return  SwitchTableViewCell() }
        
        let alarm = AlarmController.shared.alarms[indexPath.row]
        cell.alarm = alarm
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alarm = AlarmController.shared.alarms[indexPath.row]
            AlarmController.shared.delete(alarm: alarm)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    

    func switchCellSwitchValueChanged(cell: SwitchTableViewCell, enabled: Bool) {
        guard let alarm = cell.alarm,
        let cellIndexPath = tableView.indexPath(for: cell) else { return }
        tableView.beginUpdates()
        alarm.enabled = enabled
        tableView.reloadRows(at: [cellIndexPath], with: .automatic)
        tableView.endUpdates()
    }
    

    
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "toAlarmEditor" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let detailsVC = AlarmController.shared.alarms[indexPath.row]
                if let alarmsTVC = segue.destination as? AlarmDetailTableViewController{
                    alarmsTVC.alarm = detailsVC 
                }
            }
        
        }
    }
}



 

