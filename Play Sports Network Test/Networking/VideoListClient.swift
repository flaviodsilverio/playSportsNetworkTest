//
//  VideoListClient.swift
//  Play Sports Network Test
//
//  Created by Flávio Silvério on 11/02/2019.
//  Copyright © 2019 Flávio Silvério. All rights reserved.
//

import Foundation

protocol VideoListClientDelegate: class {
    func loadedVideos(videos: [Video])
    func apiError(error message: String)
}

class VideoListClient {

    weak var delegate: VideoListClientDelegate?

    var pageToken: String? = nil
    var videos = [Video]()

    func loadVideosForChannel(with name: String) {

        var requestString = BASEPATH + "playlistItems?part=snippet&maxResults=50&playlistId=UU_A--fhX5gea0i4UtpD99Gg&key=AIzaSyAJ7SZBsW40AETG7LMC_DeUA17DFf-U2Qo&order=date"

        if pageToken != nil {
            requestString.append("&pageToken=\(pageToken!)")
        }

        APIClient.shared.getRequest(for: requestString) {
            (data: Any?, response: URLResponse?, error: Error?) in

            guard let jsonData = data as? [String:Any],
                let token = jsonData["nextPageToken"] as? String,
                let jsonItems = jsonData["items"] as? [[String:Any]] else { return }

            self.pageToken = token

            jsonItems.forEach {
                item in

                if let video = Video(with: item) {
                    self.videos.append(video)
                }
            }

            DispatchQueue.main.sync {
                self.delegate?.loadedVideos(videos: self.videos)
            }
        }
        

    }
}
