//
//  FilterTableViewCell.swift
//  Yelp
//
//  Created by Tushar Humbe on 10/22/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FilterTableViewCellDelegate {
    @objc optional func filterSwitch(filterCell: FilterTableViewCell, didChangeValue: Bool)
}

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var FilterNameLabel: UILabel!
    @IBOutlet weak var filterSwitch: UISwitch!
    
    weak var delegate: FilterTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onValueChanged(_ sender: AnyObject) {
        
        delegate?.filterSwitch?(filterCell: self, didChangeValue: filterSwitch.isOn)
        
    }

}
