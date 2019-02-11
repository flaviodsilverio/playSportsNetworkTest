//
//  DetailsVC.swift
//  Play Sports Network Test
//
//  Created by Flávio Silvério on 09/02/2019.
//  Copyright © 2019 Flávio Silvério. All rights reserved.
//

import UIKit
import Kingfisher

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

        sections = [.dateAndDuration, .title, .description]

        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension

        tableView.register(UINib(nibName: "SimpleTextCell", bundle: nil), forCellReuseIdentifier: "textCell")
        tableView.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "commentCell")

        thumbnailImageView.kf.setImage(with: URL(string: video.thumbnailURL))

        APIClient.shared.getRequest(for: "https://www.googleapis.com/youtube/v3/commentThreads?key=AIzaSyAJ7SZBsW40AETG7LMC_DeUA17DFf-U2Qo&textFormat=plainText&part=snippet&videoId=6f5pAi82FSE&maxResults=100") { (data, response, error) in

            guard let jsonData = data as? JSON,
                let jsonItems = jsonData["items"] as? [JSON]
                else {
                    return

            }

            jsonItems.forEach{
                [unowned self] item in
                let c = Comment(with: item)!
                self.comments.append(c)
            }

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
        return isShowingComments ? 1 : sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isShowingComments ? comments.count : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if isShowingComments {

            let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as! CommentCell

            let url = URL(string: comments[indexPath.row].profileImage)
            print(comments[indexPath.row].profileImage)
            cell.userProfilePicture.kf.setImage(with: url)

            cell.usernameLabel.text = comments[indexPath.row].username
            cell.commentLabel.text = comments[indexPath.row].commentText

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
