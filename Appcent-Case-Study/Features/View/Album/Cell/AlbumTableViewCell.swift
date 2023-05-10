
import UIKit
import AVFoundation
final class AlbumTableViewCell: UITableViewCell {


    @IBOutlet private var trackTitle: UILabel!
    @IBOutlet private var imgView: UIImageView!
    @IBOutlet private var playBtn: UIButton!
    @IBOutlet private var imgViewBackground: UIView!
    {
        didSet{
            imgViewBackground.layer.cornerRadius = imgViewBackground.frame.size.height / 2
            imgViewBackground.clipsToBounds = true
        }
    }
    var avPlayer :AVPlayer?
    var isPlaying = false
    let url = URL(string: "https://cdns-preview-b.dzcdn.net/stream/c-bf0d36bcdd35c73c922cda15f95016f5-2.mp3")!
           
           // AVPlayer'ı oluşturun
           
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.imgView.layer.cornerRadius = 10;
        self.imgView.clipsToBounds = true
    }
    private func uiSetup(){
        /*layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.6*/
        self.backgroundColor = .secondarySystemBackground
        
       }
    func Configure(track:Track,album:Album?){
        if let album = album{
            if let imageUrl = URL(string: album.coverMedium)
                {
                    imgView.kf.setImage(with: imageUrl)
                }
        }
        uiSetup()
        trackTitle.text = track.title
    }
    private func PlayDemoTrack(){
        
    }
    
    @IBAction func playBtn(_ sender: Any) {
        if !isPlaying{
            avPlayer = AVPlayer(url: url)
            avPlayer?.play()
            isPlaying = true
        playBtn.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            let attributedString = NSAttributedString(string: "stop", attributes: [
                .foregroundColor: UIColor.black,
                .font: UIFont.systemFont(ofSize: 12),
            ])
            playBtn.setAttributedTitle(attributedString, for: .normal)
        


        }
        else{
            avPlayer?.pause()
            isPlaying = false
            playBtn.setImage(UIImage(systemName: "play.fill"), for: .normal)
            let attributedString = NSAttributedString(string: "play", attributes: [
                .foregroundColor: UIColor.black,
                .font: UIFont.systemFont(ofSize: 12),
            ])

            playBtn.setAttributedTitle(attributedString, for: .normal)

        }
        
    }
}
