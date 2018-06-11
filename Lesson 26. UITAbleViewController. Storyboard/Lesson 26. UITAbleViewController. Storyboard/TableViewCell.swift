//
//  TableViewCell.swift
//  Lesson 26. UITAbleViewController. Storyboard
//
//  Created by Anton Rubenchik on 10.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    public func getData(item: Member){
        nameLabel.text = item.name
        jobLabel.text = item.job
        
    }

}
