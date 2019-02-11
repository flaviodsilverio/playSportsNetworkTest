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

    let apiClient = VideoDetailsClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sections = [.dateAndDuration, .title, .description]

        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension

        tableView.register(UINib(nibName: "SimpleTextCell", bundle: nil), forCellReuseIdentifier: "textCell")
        tableView.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "commentCell")
        tableView.register(UINib(nibName: "DateAndDurationCell", bundle: nil), forCellReuseIdentifier: "dateCell")

        thumbnailImageView.kf.setImage(with: URL(string: video.thumbnailURL))

        apiClient.delegate = self
        apiClient.loadCommentsForVideo(with: video.id)
        apiClient.loadVideoContentDetails(for: video)

        self.view.showLoader()
    }

    @IBAction func didSelectSegment(_ sender: UISegmentedControl) {

        isShowingComments = !isShowingComments

        tableView.reloadData()

        tableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
    }

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
            cell.userProfilePicture.kf.setImage(with: url)

            cell.usernameLabel.text = comments[indexPath.row].username
            cell.commentLabel.text = comments[indexPath.row].commentText

            if indexPath.row == comments.count - 1 {
                apiClient.loadCommentsForVideo(with: video.id)
            }

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

        let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell") as! DateAndDurationCell

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        let date = dateFormatter.date(from: video.date)
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"

        cell.dateAddedLabel?.text = dateFormatter.string(from: date ?? Date())

        let time = video.duration.split(separator: "T").last
        let timeString = String(String(time ?? "").replacingOccurrences(of: "M", with: ":")).replacingOccurrences(of: "S", with: "")

        cell.durationLabel?.text = timeString

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

extension DetailsVC: VideoDetailsClientDelegate {

    func loadedContentDetails(video: Video) {
        self.video = video
        tableView.reloadData()

        self.view.hideLoader()
    }

    func loadedComments(comments: [Comment]) {
        self.comments = comments
        tableView.reloadData()
    }

    func apiError(error message: String) {

    }
}
