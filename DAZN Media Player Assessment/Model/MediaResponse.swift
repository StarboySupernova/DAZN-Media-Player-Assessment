//
//  MediaResponse.swift
//  DAZN Media Player Assessment
//
//  Created by Simbarashe Dombodzvuku on 9/10/22.
//

//   let mediaList = try? newJSONDecoder().decode(MediaResponse.self, from: jsonData)

import Foundation

// MARK: - MediaElement
struct MediaElement: Codable {
    let id, title, subtitle, date: String
    let imageURL: String
    let videoURL: String

    enum CodingKeys: String, CodingKey {
        case id, title, subtitle, date
        case imageURL = "imageUrl"
        case videoURL = "videoUrl"
    }
}

typealias MediaResponse = [MediaElement]
