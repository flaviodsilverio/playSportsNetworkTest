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

    @IBOutlet weak var tableView: UITableView!

    private var isShowingComments = false

    var comments = [Comment]()

    enum DetailsSections {
        case title
        case dateAndDuration
        case description
        case comments
    }

    var sections = [DetailsSections]()

    var video: Video!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sections = [.title, .description, .dateAndDuration, .comments]

        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension

        tableView.register(UINib(nibName: "SimpleTextCell", bundle: nil), forCellReuseIdentifier: "textCell")
        tableView.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "commentCell")


        APIClient.shared.getRequest(for: "https://www.googleapis.com/youtube/v3/commentThreads?key=AIzaSyAJ7SZBsW40AETG7LMC_DeUA17DFf-U2Qo&textFormat=plainText&part=snippet&videoId=6f5pAi82FSE&maxResults=100") { (data, response, error) in

        }

        for _ in 1...15 {
            comments.append(Comment())
        }
    }

    @IBAction func didSelectSegment(_ sender: UISegmentedControl) {

        isShowingComments = !isShowingComments

        tableView.reloadData()
        
        tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: false)

    }

}

extension DetailsVC: UITableViewDelegate {

}

extension DetailsVC: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isShowingComments ? 10 : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if isShowingComments {

            let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as! CommentCell

            return cell

        } else {
            switch sections[indexPath.section] {
            case .title:
                return titleCell()
            case .dateAndDuration:
                return dateAndDurationCell()
            case .description:
                return descriptionCell()
            default:
                return commentsCell(forRow: indexPath.row)
            }
        }
    }

    func titleCell() -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textCell") as! SimpleTextCell

        cell.titleLabel.text = "Title:"
        cell.detailLabel.text = video.title
        
        return cell
    }

    func dateAndDurationCell() -> UITableViewCell {

        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "dateAndDuration")

        cell.textLabel?.text = video.date
        cell.detailTextLabel?.text = "56:34"

        return cell
    }

    func descriptionCell() -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textCell") as! SimpleTextCell

        cell.titleLabel.text = "Description:"
        cell.detailLabel.text = video.description

        return cell
    }

    func commentsCell(forRow at: Int) -> UITableViewCell {
        return UITableViewCell()
    }
}

/*
 https://www.googleapis.com/youtube/v3/commentThreads?key=AIzaSyAJ7SZBsW40AETG7LMC_DeUA17DFf-U2Qo&textFormat=plainText&part=snippet&videoId=6f5pAi82FSE&maxResults=100
 */
