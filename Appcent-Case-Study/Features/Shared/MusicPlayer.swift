//
//  MusicPlayer.swift
//  Appcent-Case-Study
//
//  Created by Enes Talha Yılmaz on 10.05.2023.
//

import Foundation
import AVFoundation
import RxCocoa
import RxSwift

final class MusicPlayer{
    static let shared = MusicPlayer()
    var activeTrackId = BehaviorRelay<Int>(value: 0)
    private var avPlayer :AVPlayer?

    func pause()
    {
        guard let avPlayer else {return}
        avPlayer.pause()
    }
    func playTrack(url: String?,trackId:Int){
        activeTrackId.accept(trackId)
        guard let url ,let musicUrl = URL(string: url) else { return }
        avPlayer = AVPlayer(url: musicUrl)
        avPlayer?.play()
    }
}
