//
//  VideoResponse.swift
//  TrailerMateiOSApp
//
//  Created by IPH Technologies Pvt. Ltd on 26/04/22.
//

import Foundation

struct VideoSearchResponse: Codable {
    let items: [VideoElement]
}


struct VideoElement: Codable {
    let id: IdVideoElement
}


struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
