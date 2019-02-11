//
//  Comment.swift
//  Play Sports Network Test
//
//  Created by Flávio Silvério on 10/02/2019.
//  Copyright © 2019 Flávio Silvério. All rights reserved.
//

import Foundation

struct Comment {

    let username: String
    let commentText: String
    let profileImage: String

    init?(with json: JSON) {

        guard let snippet = json["snippet"] as? JSON,
            let topLevel = snippet["topLevelComment"] as? JSON,
            let innerSnippet = topLevel["snippet"] as? JSON
            else { return nil }

        username = innerSnippet["authorDisplayName"] as? String ?? ""
        commentText = innerSnippet["textDisplay"] as? String ?? ""
        profileImage = innerSnippet["authorProfileImageUrl"] as? String ?? ""
    }

}
