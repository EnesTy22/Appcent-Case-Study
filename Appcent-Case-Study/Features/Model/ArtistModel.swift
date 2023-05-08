//
//  ArtistModel.swift
//  Appcent-Case-Study
//
//  Created by Enes Talha Yılmaz on 8.05.2023.
//

import Foundation
struct Artists: Decodable {
    let data: [Artist]
}

// MARK: - Datum
struct Artist: Decodable {
    let id: Int
    let name: String
    let picture: String
    let pictureSmall, pictureMedium, pictureBig, pictureXl: String
    let radio: Bool
    let tracklist: String
    let type: TypeEnum

    enum CodingKeys: String, CodingKey {
        case id, name, picture
        case pictureSmall = "picture_small"
        case pictureMedium = "picture_medium"
        case pictureBig = "picture_big"
        case pictureXl = "picture_xl"
        case radio, tracklist, type
    }
}

