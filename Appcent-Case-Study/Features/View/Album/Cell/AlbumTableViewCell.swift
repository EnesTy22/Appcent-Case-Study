
import UIKit
import AVFoundation
import Lottie
import RxCocoa
import RxSwift

final class AlbumTableViewCell: UITableViewCell {
    
    var animationView: LottieAnimationView?
    var activeTrackIdBindVar: Disposable?

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
    
    let viewModel = AlbumTableViewCellVM()

    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imgView.layer.cornerRadius = 10;
        self.imgView.clipsToBounds = true
        self.backgroundColor = .secondarySystemBackground
        

    }

    func configure(track:Track,album:Album?){
        bind()
        if let album = album, let imageUrl = URL(string: album.coverMedium) {
                    imgView.kf.setImage(with: imageUrl)
        }
        viewModel.album = album
        viewModel.track.accept(track)
        trackTitle.text = track.title
        trackLength.text = track.duration.minuteFormat()
    }
    
    func playBtnClicked(isPlaying:Bool){
        if isPlaying && !viewModel.isAlreadyPlaying{
            viewModel.isAlreadyPlaying = true
            MusicPlayer.shared.playTrack(url:viewModel.track.value?.preview,trackId: viewModel.track.value?.id ?? 0 )
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

private extension AlbumTableViewCell{
     func bind(){
        favIconbind()
    }
     func favIconbind(){
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
    func activeTrackIdBind(){
        activeTrackIdBindVar = MusicPlayer.shared.activeTrackId
           .distinctUntilChanged()
           .subscribe { [weak self] response in
               if response.element != self?.viewModel.track.value?.id {
                   self?.activeTrackIdBindVar?.dispose()
                   self?.playBtnClicked(isPlaying: false)
           }
           
       }
   }
     func addItFav(){
        favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
     func removeFav(){
        favBtn.setImage(UIImage(systemName: "heart"), for: .normal)
    }
}
