//
//  AlarmListTableViewController.swift
//  Alarm
//
//  Created by Josh & Erica on 2/6/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController, SwitchTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

       // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return AlarmController.shared.alarms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? SwitchTableViewCell else { return  SwitchTableViewCell() }
        
        let alarm = AlarmController.shared.alarms[indexPath.row]
        cell.alarm = alarm
        

        return cell
    }
    

    func switchCellSwitchValueChanged(cell: SwitchTableViewCell, enabled: Bool) {
        guard let alarm = cell.alarm,
        let cellIndexPath = tableView.indexPath(for: cell) else { return }
        tableView.beginUpdates()
        alarm.enabled = enabled
        tableView.reloadRows(at: [cellIndexPath], with: .automatic)
        tableView.endUpdates()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alarm = AlarmController.shared.alarms[indexPath.row]
            AlarmController.shared.delete(alarm: alarm)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 }
 

