
import UIKit
import AVFoundation
import Lottie
import RxSwift
import RxCocoa

final class FavoritesTableViewCell: UITableViewCell {
    var activeTrackIdBindVar : Disposable?
    var animationView : LottieAnimationView?


    @IBOutlet private var trackTitle: UILabel!
    @IBOutlet private var imgView: UIImageView!
    @IBOutlet var favBtn: UIButton!
    @IBOutlet var trackLength: UILabel!
    @IBOutlet private var playBtn: UIButton!{
        didSet{
            playBtn.setTitleColor(.blue, for: .normal)
            playBtn.isUserInteractionEnabled = false

        }
    }
    @IBOutlet private var imgViewBackground: UIView!
    {
        didSet{
            imgViewBackground.layer.cornerRadius = imgViewBackground.frame.size.height / 2
            imgViewBackground.clipsToBounds = true
        }
    }
    
    let viewModel = FavoritesTableViewCellVM()

    
    override func layoutSubviews() {
        super.layoutSubviews()
        bind()
        self.imgView.layer.cornerRadius = 10;
        self.imgView.clipsToBounds = true
        self.backgroundColor = .secondarySystemBackground
    
    }

    func configure(track:Track,trackCover:String?){
        if let trackCover = trackCover, let imageUrl = URL(string: trackCover) {
                    imgView.kf.setImage(with: imageUrl)
        }
        trackTitle.text = track.title
        trackLength.text = track.duration.minuteFormat()
    }
    func reloadConfigure(favoriteVC:FavoritesVC,trackId:Int,trackCover:String){
        viewModel.favoriteVc = favoriteVC
        viewModel.trackCover = trackCover
        viewModel.trackId.accept(trackId)
    }
    
    func playBtnClicked(isPlaying:Bool){
        if isPlaying && !viewModel.isAlreadyPlaying{
            viewModel.isAlreadyPlaying = true
            MusicPlayer.shared.playTrack(url:viewModel.track.value?.preview,trackId: viewModel.trackId.value)
            animationView = .init(name:"Play")
            animationView?.frame = playBtn.bounds
            playBtn.addSubview(animationView!)
            animationView?.loopMode = .loop
            animationView?.play()
            playBtn.setImage(UIImage(), for: .normal)
            let attributedString = NSAttributedString(string: "", attributes: [
                .foregroundColor: UIColor.black,
                .font: UIFont.systemFont(ofSize: 12),
            ])
            playBtn.setAttributedTitle(attributedString, for: .normal)
        activeTrackIdBind()


        }
        else{
            viewModel.isAlreadyPlaying = false
            MusicPlayer.shared.pause()
            animationView?.removeFromSuperview()
            animationView = nil
            playBtn.setImage(UIImage(systemName: "play.fill"), for: .normal)
            
            let attributedString = NSAttributedString(string: "play", attributes: [
                .foregroundColor: UIColor.black,
                .font: UIFont.systemFont(ofSize: 12),
            ])

            playBtn.setAttributedTitle(attributedString, for: .normal)

        }
    }
   
    @IBAction func addFavBtn(_ sender: Any) {
        viewModel.addToFavList()
    }
}

private extension FavoritesTableViewCell{
    private func bind(){
        favIconBind()
        trackBind()
    }
    func activeTrackIdBind(){
        activeTrackIdBindVar = MusicPlayer.shared.activeTrackId
            .distinctUntilChanged()
            .subscribe { [weak self] response in
                self?.checkIfMusicActive(response: response.element, id: self?.viewModel.track.value?.id)
            }
        
    }
    func checkIfMusicActive(response:Int?,id:Int?){
        if response != id {
            activeTrackIdBindVar?.dispose()
            playBtnClicked(isPlaying: false)
        }
        
    }
    
        func favIconBind(){
            viewModel.isInFav
                .distinctUntilChanged()
                .subscribe { [weak self] response in
                    
                    if response {
                        self?.addItFav()
                    }
                    else{
                        self?.removeFav()
                    }
                    
                }.disposed(by: viewModel.disposeBag)
        }
        func trackBind(){
            viewModel.track
                .compactMap{$0}
                .subscribe { [weak self] response in
                    self?.configure(track: response, trackCover:self?.viewModel.trackCover)
                    //self?.checkIfMusicActive(response: MusicPlayer.shared.activeTrackId.value, id: response.id)
                }.disposed(by: viewModel.disposeBag)
        }
        func addItFav(){
            favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        func removeFav(){
            favBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
    }
