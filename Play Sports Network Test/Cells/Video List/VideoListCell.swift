//
//  VideoListCell.swift
//  Play Sports Network Test
//
//  Created by Flávio Silvério on 09/02/2019.
//  Copyright © 2019 Flávio Silvério. All rights reserved.
//

import UIKit

class VideoListCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
