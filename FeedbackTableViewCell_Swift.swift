//
//  FeedbackTableViewCell_Swift.swift
//  FFT Form
//
//  Created by Welltime on 07/09/2017.
//  Copyright © 2017 Welltime. All rights reserved.
//

import UIKit

class FeedbackTableViewCell_Swift: UITableViewCell {

    
    @IBOutlet weak var img_icon: UIImageView!
    
    
    @IBOutlet weak var lbl_name: UILabel!
    
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
