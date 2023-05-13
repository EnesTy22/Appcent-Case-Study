//
//  ArtistDetailVM.swift
//  Appcent-Case-Study
//
//  Created by Enes Talha Yılmaz on 9.05.2023.
//

import Foundation
import RxSwift
import RxCocoa

struct ArtistDetailVM{
    
    let disposeBag = DisposeBag()
    let artist = BehaviorRelay<Artist?>(value : nil)
    let albums = BehaviorRelay<[Album]>(value: [])
    
    private func fetchAlbums(artist:Artist){
        let artistId = String(artist.id)
        
       
        DeezerService.shared.request(path: DeezerServicePath.allAlbumPath(artistId: artistId)) {
            (response:Albums) in
            self.albums.accept(response.data)
        } onFail: { error in
            
        }

    }
    
    init(){
        bind()
    }
}
private extension ArtistDetailVM{
    private func bind(){
        Artistbind()
    }
    private func Artistbind(){
        artist.compactMap{$0}
            .subscribe { response in
                self.fetchAlbums(artist: response)

        }.disposed(by: disposeBag)
    }
}
