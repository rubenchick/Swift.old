// Switch controll
//  SecondTodayHistoryTableViewCell.swift
//  Daily Routine
//
//  Created by Anton Rubenchik on 21.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
protocol SecondMainTableViewCellDelegate {
    func didTappedSwitchCell(cell: SecondTodayHistoryTableViewCell)
}

class SecondTodayHistoryTableViewCell: UITableViewCell {
    var delegate: SecondMainTableViewCellDelegate!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var isActualSwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    public func getData(item: Thing) {
        nameLabel.text = item.name
        noteLabel.text = item.note
        isActualSwitch.isOn = item.isActual
        nameLabel.frame.size = CGSize(width: self.frame.width - 100, height: nameLabel.frame.height)
    }
    @IBAction func isDoneSwitch(_ sender: UISwitch) {
        delegate.didTappedSwitchCell(cell: self)
    }
}
