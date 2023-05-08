//
//  DeezerService+Path.swift
//  Appcent-Case-Study
//
//  Created by Enes Talha Yılmaz on 8.05.2023.
//

import Foundation

extension DeezerServicePath
{
    static func allGenresPath()-> String{
        return "\(BASE_URL.rawValue)\(GENREPATH.rawValue)"
    }
    static func selectedAlbumPath(artistId:String,albumId:String)-> String{
        return "\(BASE_URL.rawValue)\(ALBUMPATH.rawValue)/\(albumId)"
    }
    static func allAlbumPath(artistId:String)-> String{
        return "\(BASE_URL.rawValue)\(ARTISTPATH.rawValue)/\(artistId)\(ALBUMSPATH.rawValue)"
    }
    static func selectedGenrePath(genreId:String)-> String{
        return "\(BASE_URL.rawValue)\(GENREPATH.rawValue)/\(genreId)\(ARTISTSPATH.rawValue)"
    }
    static func selectedArtistPath(artistId:String)-> String{
        return "\(BASE_URL.rawValue)\(ARTISTPATH.rawValue)/\(artistId)"
    }
}
