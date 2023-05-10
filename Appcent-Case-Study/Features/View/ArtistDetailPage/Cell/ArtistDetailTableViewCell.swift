//
//  ArtistDetailTableViewCell.swift
//  Appcent-Case-Study
//
//  Created by Enes Talha Yılmaz on 9.05.2023.
//

import UIKit
class ArtistDetailTableViewCell: UITableViewCell {


    @IBOutlet var imgViewBackground: UIView!{
        didSet{
            imgViewBackground.layer.cornerRadius = imgViewBackground.frame.size.height / 2
            imgViewBackground.clipsToBounds = true
        }
    }
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var albumTitle: UILabel!
    @IBOutlet var releaseDateTitle: UILabel!
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
    func Configure(album:Album){
        if let imageUrl = URL(string: album.coverMedium)
        {
            imgView.kf.setImage(with: imageUrl)
        }
        uiSetup()

        
        albumTitle.text = album.title
        releaseDateTitle.text = album.releaseDate
    }
    
    //static let nibName = ArtistDetailTableViewCell.na
    
}
