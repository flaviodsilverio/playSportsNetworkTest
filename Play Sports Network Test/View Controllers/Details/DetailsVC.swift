//
//  DetailsVC.swift
//  Play Sports Network Test
//
//  Created by Flávio Silvério on 09/02/2019.
//  Copyright © 2019 Flávio Silvério. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var commentsTableView: UITableView!

    var video: Video! {
        didSet {
            titleLabel.text = video.title
            dateLabel.text = video.date
            durationLabel.text = "58:52"
            descriptionLabel.text = video.description

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func closePage(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
