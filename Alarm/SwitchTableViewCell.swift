//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Josh & Erica on 2/6/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

//Pro
protocol SwitchTableViewCellDelegate: class {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell, enabled: Bool)
    
//Class
}

class SwitchTableViewCell: UITableViewCell {
    
    weak var delegate: SwitchTableViewCellDelegate?

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    var alarm: Alarm? {
        didSet {
            guard let alarm = alarm else { return }
            timeLabel.text = alarm.fireTimeAsString
            nameLabel.text = alarm.name
            alarmSwitch.isOn = alarm.enabled
        }
    }
    
    @IBAction func switchValueChanged(_ sender: Any) {
        delegate?.switchCellSwitchValueChanged(cell: self, enabled: alarmSwitch.isOn)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
