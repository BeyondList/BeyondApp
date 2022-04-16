//
//  TestTaskTableViewCell.swift
//  BeyondList
//
//  Created by Mark on 4/10/22.
//

import UIKit

class TestTaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var roundedView: UIView!

    var taskObjectId = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
