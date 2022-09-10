//
//  MediaResponse.swift
//  DAZN Media Player Assessment
//
//  Created by Simbarashe Dombodzvuku on 9/10/22.
//

//   let mediaList = try? newJSONDecoder().decode(MediaResponse.self, from: jsonData)

import Foundation

// MARK: - MediaElement
struct MediaElement: Codable, Identifiable {
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

/*struct MediaResponse: Codable {
    let elements: [MediaElement]
}
 */

extension MediaElement {
    static var dummyData: MediaElement {
        .init(id: "1", title: "Liverpool v Porto", subtitle: "UEFA Champions League", date: "2022-09-10T01:51:22.337Z", imageURL: "https://firebasestorage.googleapis.com/v0/b/dazn-recruitment/o/310176837169_image-header_pDach_1554579780000.jpeg?alt=media&token=1777d26b-d051-4b5f-87a8-7633d3d6dd20", videoURL: "https://firebasestorage.googleapis.com/v0/b/dazn-recruitment/o/promo.mp4?alt=media")
    }
}
/*
 "id":"1","title":"Liverpool v Porto","subtitle":"UEFA Champions League","date":"2022-09-10T01:51:22.337Z","imageUrl":"https://firebasestorage.googleapis.com/v0/b/dazn-recruitment/o/310176837169_image-header_pDach_1554579780000.jpeg?alt=media&token=1777d26b-d051-4b5f-87a8-7633d3d6dd20","videoUrl":"https://firebasestorage.googleapis.com/v0/b/dazn-recruitment/o/promo.mp4?alt=media"
 */
