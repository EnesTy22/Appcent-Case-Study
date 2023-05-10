//
//  AlbumModel.swift
//  Appcent-Case-Study
//
//  Created by Enes Talha Yılmaz on 8.05.2023.
//

import Foundation

struct Albums:Decodable
{
        let data: [Album]
        let total: Int?
}

struct Album: Decodable {
    let id: Int
    let title: String
    let cover: String
    let coverSmall, coverMedium, coverBig, coverXl: String
    let md5Image: String
    let genreID, fans: Int?
    let releaseDate: String?
    let recordType: RecordTypeEnum?
    let tracklist: String
    let type: RecordTypeEnum
    enum CodingKeys: String, CodingKey {
        case id, title, cover
        case coverSmall = "cover_small"
        case coverMedium = "cover_medium"
        case coverBig = "cover_big"
        case coverXl = "cover_xl"
        case md5Image = "md5_image"
        case genreID = "genre_id"
        case fans
        case releaseDate = "release_date"
        case recordType = "record_type"
        case tracklist
        case type
    }
}
enum RecordTypeEnum: String, Decodable {
    case album = "album"
    case single = "single"
    case ep = "ep"

}
