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
    
    /*
     https://developers.google.com/apis-explorer/#p/youtube/v3/youtube.channels.list?
     part=snippet,contentDetails
     &id=UCK8sQmJBp8GCxrOtXWBpyEA
     */

    var items = [Video]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension

        let cell = UINib(nibName: "VideoListCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "cell")

        /*
         https://developers.google.com/apis-explorer/#p/youtube/v3/youtube.channels.list?
         part=contentDetails
         &forUsername=Google
         */

        //https://www.googleapis.com/youtube/v3/channels?part=contentDetails&forUsername=OneDirectionVEVO&key={YOUR_API_KEY}

        //let url = URL(string: "https://www.googleapis.com/youtube/v3/youtube.channels.list?key=AIzaSyAJ7SZBsW40AETG7LMC_DeUA17DFf-U2Qo&part=contentDetails&forUsername=globalmtb")

        /*requestForURL(string: "https://www.googleapis.com/youtube/v3/channels?part=contentDetails&forUsername=globalmtb&key=AIzaSyAJ7SZBsW40AETG7LMC_DeUA17DFf-U2Qo") {
            (data: Any?, response: URLResponse?, error: Error?) in

            //print(data)

        }*/

        APIClient.shared.getRequest(for: "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=UU_A--fhX5gea0i4UtpD99Gg&key=AIzaSyAJ7SZBsW40AETG7LMC_DeUA17DFf-U2Qo") {
            (data: Any?, response: URLResponse?, error: Error?) in


            guard let jsonData = data as? [String:Any],
                let jsonItems = jsonData["items"] as? [[String:Any]] else { return }

            jsonItems.forEach {
                [unowned self] item in

                if let video = Video(with: item) {
                    self.items.append(video)
                }
            }

            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let destination = segue.destination as? DetailsVC {

            destination.video = items[tableView.indexPathForSelectedRow?.row ?? 0]

        }

    }
    /*
     AIzaSyAJ7SZBsW40AETG7LMC_DeUA17DFf-U2Qo
     https://www.googleapis.com/youtube/v3/videos?id=7lCDEYXw3mM&key=YOUR_API_KEY
     &part=snippet,contentDetails,statistics,status
     */

    
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
            print(items[indexPath.row].thumbnailURL)
            cell.thumbnailImageView.kf.setImage(with: URL(string: items[indexPath.row].thumbnailURL))

            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

}
