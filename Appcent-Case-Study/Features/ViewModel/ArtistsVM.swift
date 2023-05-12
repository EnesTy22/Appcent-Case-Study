//
//  ArtistVM.swift
//  Appcent-Case-Study
//
//  Created by Enes Talha Yılmaz on 9.05.2023.
//

import Foundation
import RxSwift
import RxCocoa

final class ArtistsVM{
    let disposeBag = DisposeBag()
    let AllArtist = BehaviorRelay<[Artist]>(value: [])
    let loading = BehaviorRelay(value: false)
    let genre = BehaviorRelay<Genre?>(value:nil)

    init(){
        bind()
    }
    
    private func fetchAllArtists(genre:Genre){
        
        loading.accept(true)
        let genreId = String(genre.id)
        DeezerService.shared.request(path: DeezerServicePath.selectedGenrePath(genreId: genreId)) { (response:Artists) in
            self.AllArtist.accept(response.data)
        } onFail: { error in
            
        }

    }
    
}
private extension ArtistsVM {
    func bind(){
        genreBind()
    }
    func genreBind(){
        genre
            .compactMap{$0}
            .subscribe { [weak self] genre in
                self?.fetchAllArtists(genre: genre)
            }.disposed(by: disposeBag)
    }
}
