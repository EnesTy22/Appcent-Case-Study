
import Foundation
import RxSwift
import RxCocoa

struct AlbumVM
{
    let disposeBag = DisposeBag()
    let artist = BehaviorRelay<Artist?>(value: nil)
    let album = BehaviorRelay<Album?>(value: nil)
    let allTracks = BehaviorRelay<[Track]>(value: [])
    
    init(){
        bind()
    }
    func fetchAllTracks(artist:Artist,album:Album){
        let artistId = String(artist.id)
        let albumId = String(album.id)
        DeezerService.shared.request(path: DeezerServicePath.selectedAlbumPath(artistId: artistId, albumId: albumId)) { (response:TrackDatas) in
            allTracks.accept(response.tracks.data)
        } onFail: { error in
            
        }

    }
    
}
extension AlbumVM{
    
    func bind(){
        combine()
    }
    
    func combine(){
        let combined = Observable.zip(artist, album)
            .subscribe(onNext: { artist, album in
                guard let artist = artist, let album = album else {
                            return
                        }
                fetchAllTracks(artist: artist, album: album)
            }).disposed(by: disposeBag)
    }
    
}
