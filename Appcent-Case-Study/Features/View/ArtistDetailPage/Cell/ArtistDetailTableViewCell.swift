//
//  ArtistDetailTableViewCell.swift
//  Appcent-Case-Study
//
//  Created by Enes Talha Yılmaz on 9.05.2023.
//

import UIKit
final class ArtistDetailTableViewCell: UITableViewCell {


    @IBOutlet var imgViewBackground: UIView!{
        didSet{
            imgViewBackground.layer.cornerRadius = imgViewBackground.frame.size.height / 2
            imgViewBackground.clipsToBounds = true
        }
    }
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var albumTitle: UILabel!
    @IBOutlet var releaseDateTitle: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .secondarySystemBackground
        self.imgView.layer.cornerRadius = 10;
        self.imgView.clipsToBounds = true
    }
    
    func Configure(album:Album){
        if let imageUrl = URL(string: album.coverMedium)
        {
            imgView.kf.setImage(with: imageUrl)
        }

        
        albumTitle.text = album.title
        releaseDateTitle.text = album.releaseDate
    }
    
    
}
