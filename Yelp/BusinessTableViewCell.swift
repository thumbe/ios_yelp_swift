//
//  BusinessTableViewCell.swift
//  Yelp
//
//  Created by Tushar Humbe on 10/21/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingsImageView: UIImageView!
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var business: Business! {
        didSet {
            nameLabel.text = business.name;
            ratingsImageView.setImageWith(business.ratingImageURL!)
            thumbnailImageView.setImageWith(business.imageURL!)
            categoryLabel.text = business.categories
            distanceLabel.text = business.distance
            reviewLabel.text = "\(business.reviewCount!) Reviews"
            addressLabel.text = business.address
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbnailImageView.layer.cornerRadius = 3
        thumbnailImageView.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
        thumbnailImageView.setImageWith(business.imageURL!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
