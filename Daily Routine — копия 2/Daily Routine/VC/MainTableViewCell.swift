//
//  MainTableViewCell.swift
//  Daily Routine
//
//  Created by Anton Rubenchik on 17.07.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit
protocol MainTableViewCellDelegate {
    func didTappedSwitchCell(cell: MainTableViewCell)
}

class MainTableViewCell: UITableViewCell {
    var delegate: MainTableViewCellDelegate!
    @IBOutlet weak var nameCell: UILabel!
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
        nameCell.text = item.name
        noteLabel.text = item.note
        isActualSwitch.isOn = item.isActual
    }
    
    @IBAction func tappedSwitch(_ sender: UISwitch) {
        delegate.didTappedSwitchCell(cell: self)
    }
}
