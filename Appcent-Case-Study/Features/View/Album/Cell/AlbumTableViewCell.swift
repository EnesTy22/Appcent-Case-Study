
import UIKit
import AVFoundation
final class AlbumTableViewCell: UITableViewCell {


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

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
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
        if(viewModel.track == nil){
            
        }
        viewModel.track.accept(track)
        trackTitle.text = track.title
        trackLength.text = track.duration.minuteFormat()
    }
    
    func playBtnClicked(isPlaying:Bool){
        if isPlaying && !viewModel.isAlreadyPlaying{
            viewModel.isAlreadyPlaying = true
            MusicPlayer.shared.playTrack(url:viewModel.track.value?.preview )
        playBtn.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            let attributedString = NSAttributedString(string: "stop", attributes: [
                .foregroundColor: UIColor.black,
                .font: UIFont.systemFont(ofSize: 12),
            ])
            playBtn.setAttributedTitle(attributedString, for: .normal)
        


        }
        else{
            viewModel.isAlreadyPlaying = false
            MusicPlayer.shared.pause()
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
    private func bind(){
        favIconbind()
    }
    private func favIconbind(){
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
    private func addItFav(){
        favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
    private func removeFav(){
        favBtn.setImage(UIImage(systemName: "heart"), for: .normal)
    }
}
