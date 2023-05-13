
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
            imgViewBackground.layer.cornerRadius = imgViewBackground.frame.size.height * 3.15
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
        if(viewModel.trackId.value == MusicPlayer.shared.activeTrackId.value){
            viewModel.isAlreadyPlaying = true
            
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
        //activeTrackIdBind()
        }
        else{
            viewModel.isAlreadyPlaying = false
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
    func attributedString(text:String){
        let attributedString = NSAttributedString(string: "\(text)", attributes: [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 12),
        ])
        playBtn.setAttributedTitle(attributedString, for: .normal)

    }
    func onMusicStartIcon(){
        if(animationView == nil){
            animationView = .init(name:"Play")
            animationView?.frame = playBtn.bounds
            playBtn.addSubview(animationView!)
            animationView?.loopMode = .loop
            animationView?.play()
            playBtn.setImage(UIImage(), for: .normal)
        }
        
    }
    func playBtnClicked(isPlaying:Bool){
        if isPlaying && !viewModel.isAlreadyPlaying{
            viewModel.isAlreadyPlaying = true
            MusicPlayer.shared.playTrack(url:viewModel.track.value?.preview,trackId: viewModel.trackId.value)
            onMusicStartIcon()
            attributedString(text: "")

        }
        else{
            viewModel.isAlreadyPlaying = false
            MusicPlayer.shared.pause()
            animationView?.removeFromSuperview()
            animationView = nil
            playBtn.setImage(UIImage(systemName: "play.fill"), for: .normal)
            attributedString(text: "play")
        }
    }
   
    @IBAction func addFavBtn(_ sender: Any) {
        viewModel.addToFavList()
    }
}

private extension FavoritesTableViewCell{
    func bind(){
        favIconBind()
        trackBind()
    }
    
    func favIconBind(){
        viewModel.isInFav
            .distinctUntilChanged()
            .subscribe { [weak self] response in
                var iconType = response ? ".fill" : ""
                self?.favBtn.setImage(UIImage(systemName: "heart\(iconType)"), for: .normal)
            }.disposed(by: viewModel.disposeBag)
    }
    
    func trackBind(){
        viewModel.track
            .compactMap{$0}
            .subscribe { [weak self] response in
                self?.configure(track: response, trackCover:self?.viewModel.trackCover)
            }.disposed(by: viewModel.disposeBag)
    }
    
}
