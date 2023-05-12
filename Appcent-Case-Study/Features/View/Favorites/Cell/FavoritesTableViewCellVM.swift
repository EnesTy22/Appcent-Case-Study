//
//  AlbumTableViewCellVM.swift
//  Appcent-Case-Study
//
//  Created by Enes Talha Yılmaz on 11.05.2023.
//

import Foundation
import RxSwift
import RxCocoa
final class FavoritesTableViewCellVM{
    
    let disposeBag = DisposeBag()
    var track = BehaviorRelay<Track?>(value :nil)
    var trackId = BehaviorRelay<Int>(value :0)
    var trackCover : String?
    var isAlreadyPlaying = false
    var isInFav = BehaviorRelay<Bool>(value: true)

    init()
    {
        bind()
    }
    func addToFavList()
    {
        if(CoreService.shared?.checkIfItemExist(trackId: track.value?.id) == true){
            isInFav.accept(false)
            CoreService.shared?.deleteFavTrack(trackId: track.value?.id)
        }
        else{
            isInFav.accept(true)
            CoreService.shared?.addFavTrack(trackId: track.value?.id,trackCover: trackCover)
        }
    }

    func fetchFavTrack(trackId:Int){
        let trackId = String(trackId)
        DeezerService.shared.request(path: DeezerServicePath.selectedTrackPath(trackId: trackId)) {[weak self] (response:Track) in
            self?.track.accept(response)
        } onFail: { _ in
            
        }

    }
}
private extension FavoritesTableViewCellVM{
     func bind(){
        trackBind()
    }
     func trackBind(){
        trackId
            .compactMap{$0}
            .subscribe { [weak self] trackId in
                    self?.fetchFavTrack(trackId: trackId)
            }.disposed(by: disposeBag)
    }
    
}


