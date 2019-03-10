//
//  DatailTableViewCell.swift
//  Verbs.Hebrew
//
//  Created by Anton Rubenchik on 10/03/2019.
//  Copyright © 2019 Anton Rubenchik. All rights reserved.
//

import UIKit

class DatailTableViewCell: UITableViewCell {

    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var translateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func getData(tens: WordInTense) {
        bodyLabel.text = tens.body
        wordLabel.text = tens.word
        translateLabel.text = tens.translation
//        nameLabel.frame.size = CGSize(width: self.frame.width - 100, height: nameLabel.frame.height)
    }

}
