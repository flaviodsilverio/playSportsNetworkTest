//
//  ListVC.swift
//  Play Sports Network Test
//
//  Created by Flávio Silvério on 09/02/2019.
//  Copyright © 2019 Flávio Silvério. All rights reserved.
//

import UIKit
import Kingfisher

class ListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var items = [Video]()

    let apiClient = VideoListClient()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension

        let cell = UINib(nibName: "VideoListCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "cell")

        apiClient.delegate = self
        apiClient.loadVideosForChannel(with: "")

        self.view.showLoader()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let destination = segue.destination as? DetailsVC {

            destination.video = items[tableView.indexPathForSelectedRow?.row ?? 0]
        }
    }
}

extension ListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showVideoDetails", sender: self)
    }
}

extension ListVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? VideoListCell {

            cell.titleLabel.text = items[indexPath.row].title
            cell.thumbnailImageView.kf.setImage(with: URL(string: items[indexPath.row].thumbnailURL))
            
            if indexPath.row == items.count - 1{
                apiClient.loadVideosForChannel(with: "")
            }

            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}

extension ListVC: VideoListClientDelegate {

    func apiError(error message: String) {

    }

    func loadedVideos(videos: [Video]) {

        self.view.hideLoader()

        items = videos
        tableView.reloadData()
    }
}
