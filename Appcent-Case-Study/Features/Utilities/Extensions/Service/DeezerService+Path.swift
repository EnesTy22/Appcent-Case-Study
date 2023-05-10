import Foundation

extension DeezerServicePath
{
    static func allGenresPath()-> String{
        return "\(GENREPATH.rawValue)"
    }
    static func selectedAlbumPath(artistId: String,albumId: String)-> String{
        return "\(ALBUMPATH.rawValue)/\(albumId)"
    }
    static func allAlbumPath(artistId: String)-> String{
        return "\(ARTISTPATH.rawValue)/\(artistId)\(ALBUMSPATH.rawValue)"
    }
    static func selectedGenrePath(genreId: String)-> String{
        return "\(GENREPATH.rawValue)/\(genreId)\(ARTISTSPATH.rawValue)"
    }
    static func selectedArtistPath(artistId: String)-> String{
        return "\(ARTISTPATH.rawValue)/\(artistId)"
    }
}
