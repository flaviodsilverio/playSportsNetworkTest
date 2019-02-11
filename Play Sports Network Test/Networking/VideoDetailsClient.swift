//
//  VideoDetailsClient.swift
//  Play Sports Network Test
//
//  Created by Flávio Silvério on 11/02/2019.
//  Copyright © 2019 Flávio Silvério. All rights reserved.
//

import Foundation

protocol VideoDetailsClientDelegate: class {
    func loadedComments(comments: [Comment])
    func loadedContentDetails(video: Video)
    func apiError(error message: String)
}

class VideoDetailsClient {

    weak var delegate: VideoDetailsClientDelegate?

    var comments = [Comment]()

    func loadVideoContentDetails(for video: Video) {

        let urlString = BASEPATH + "videos?id=\(video.id)&part=contentDetails&key=AIzaSyAJ7SZBsW40AETG7LMC_DeUA17DFf-U2Qo"

        APIClient.shared.getRequest(for: urlString) {
            (data: Any?, response: URLResponse?, error: Error?) in

            guard let jsonData = data as? JSON,
                  let items = jsonData["items"] as? [JSON],
                  let item = items.first
                else { return }

            var v = video
            v.addDuration(from: item)

            DispatchQueue.main.sync {
                self.delegate?.loadedContentDetails(video: v)
            }
        }
    }

    func loadCommentsForVideo(with id: String) {

        let requestString = BASEPATH + "commentThreads?key=AIzaSyAJ7SZBsW40AETG7LMC_DeUA17DFf-U2Qo&textFormat=plainText&part=snippet&videoId=\(id)&maxResults=100"

        APIClient.shared.getRequest(for: requestString) {
            (data: Any?, response: URLResponse?, error: Error?) in


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

            DispatchQueue.main.sync {
                self.delegate?.loadedComments(comments: self.comments)
            }
            }
        }
}

