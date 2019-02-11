//
//  VideoDetailsClient.swift
//  Play Sports Network Test
//
//  Created by Flávio Silvério on 11/02/2019.
//  Copyright © 2019 Flávio Silvério. All rights reserved.
//

import Foundation
/*
https://www.googleapis.com/youtube/v3/videos?id=9imVeD3ARq4&part=contentDetails&key=AIzaSyAJ7SZBsW40AETG7LMC_DeUA17DFf-U2Qo
 */

protocol VideoDetailsClientDelegate: class {
    func loadedComments(comments: [Comment])
    func loadedContentDetails(video: Video)
    func apiError(error message: String)
}

class VideoDetailsClient {

    weak var delegate: VideoDetailsClientDelegate?

    var pageToken: String? = nil
    var comments = [Comment]()

    func loadVideoContentDetails(for video: Video) {

        APIClient.shared.getRequest(for: "https://www.googleapis.com/youtube/v3/videos?id=\(video.id)&part=contentDetails&key=AIzaSyAJ7SZBsW40AETG7LMC_DeUA17DFf-U2Qo") {
            (data: Any?, response: URLResponse?, error: Error?) in

            print(data)

        }
    }

    func loadCommentsForVideo(with id: String) {

        var requestString = "https://www.googleapis.com/youtube/v3/commentThreads?key=AIzaSyAJ7SZBsW40AETG7LMC_DeUA17DFf-U2Qo&textFormat=plainText&part=snippet&videoId=\(id)&maxResults=100"

        if pageToken != nil {
            requestString.append("&pageToken=\(pageToken!)")
        }

        APIClient.shared.getRequest(for: requestString) {
            (data: Any?, response: URLResponse?, error: Error?) in


            guard let jsonData = data as? JSON,
                let token = jsonData["nextPageToken"] as? String,
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

