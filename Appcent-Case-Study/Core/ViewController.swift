//
//  ViewController.swift
//  Appcent-Case-Study
//
//  Created by Enes Talha Yılmaz on 8.05.2023.
//

import UIKit

class ViewController: UIViewController {

    var deezerService:DeezerServiceProtocol = DeezerService()
    override func viewDidLoad() {
        //deezerService.request(path: DeezerServicePath.allGenresPath()) {  //(selectedGenre:Genres) in
        //    print(selectedGenre)
//
        //} onFail: { error in
        //    print(error)
        //}
        //deezerService.request(path: DeezerServicePath.allAlbumPath(artistId: "8354140")) {  //(selectedGenre:AlbumsModel) in
        //   print(selectedGenre)
        //} onFail: { error in
        //    print(error)
        //}
        //deezerService.request(path: DeezerServicePath.selectedGenrePath(genreId: "0")) {  //(selectedGenre:Artists) in
        //   print(selectedGenre)
        //} onFail: { error in
        //    print(error)
        //}
        //deezerService.request(path: DeezerServicePath.selectedArtistPath(artistId: //"8354140")) {  (selectedGenre:Artist) in
        //   print(selectedGenre)
        //} onFail: { error in
        //    print(error)
        //}
        
        deezerService.request(path: DeezerServicePath.selectedAlbumPath(artistId: "8354140", albumId: "168136152")) {  (selectedGenre:TrackDatas) in
           print(selectedGenre)
        } onFail: { error in
            print(error)
        }
    }
}

