//
//  AlbumTableViewCellVM.swift
//  Appcent-Case-Study
//
//  Created by Enes Talha Yılmaz on 11.05.2023.
//

import Foundation
import RxSwift
import RxCocoa

final class AlbumTableViewCellVM{
    let disposeBag = DisposeBag()
    var track = BehaviorRelay<Track?>(value :nil)
    var album:Album?
    var isAlreadyPlaying = false
    var isInFav = BehaviorRelay<Bool>(value: false)
    
    init() {
        bind()
    }
    func checkTrackFavState(){
        if(CoreService.shared?.checkIfItemExist(trackId: track.value?.id) ?? false){
            isInFav.accept(true)
        }
        else{
            isInFav.accept(false)
        }
    }
    func addToFavList()
    {
        if(CoreService.shared?.checkIfItemExist(trackId: track.value?.id) ?? false){
            isInFav.accept(false)
            CoreService.shared?.deleteFavTrack(trackId: track.value?.id)
        }
        else{
            isInFav.accept(true)
            CoreService.shared?.addFavTrack(trackId: track.value?.id,trackCover:album?.coverMedium)
        }
    }
}
private extension AlbumTableViewCellVM{
    private func bind(){
        trackBind()
    }
    private func trackBind(){
        track.subscribe { [weak self] response in
            self?.checkTrackFavState()
        }.disposed(by: disposeBag)
    }
}
