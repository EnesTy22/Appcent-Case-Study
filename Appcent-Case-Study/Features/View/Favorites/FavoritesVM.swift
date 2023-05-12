//
//  FavoritesVM.swift
//  Appcent-Case-Study
//
//  Created by Enes Talha Yılmaz on 11.05.2023.
//

import Foundation
import RxSwift
import RxCocoa

struct FavoritesVM{
    let disposeBag = DisposeBag()
    var allFavoriteTrackId = BehaviorRelay<[Int]>(value: [])
    var allFavoriteTrackCover = BehaviorRelay<[String]>(value: [])
    
    
    init() {
        fetchAllFavoritesId()
        bind()
    }
    
    private func fetchAllFavoritesId(){
        let nsFavGameLists = CoreService.shared?.allFavTrackList() ?? []
        allFavoriteTrackId.accept([])
        allFavoriteTrackCover.accept([])
        nsFavGameLists.forEach{ item in
            allFavoriteTrackId.accept(allFavoriteTrackId.value + [item.value(forKey: "trackId") as? Int ?? 0])
            allFavoriteTrackCover.accept(allFavoriteTrackCover.value + [item.value(forKey: "trackCover") as? String ?? ""])
        }
        
    }
    
    
}
    private extension FavoritesVM{
        func bind(){
            reloadBind()
        }
        func reloadBind(){
            CoreService.shared?.reloadPage.subscribe { _ in
                self.fetchAllFavoritesId()
            }.disposed(by: disposeBag)
        }
    }
