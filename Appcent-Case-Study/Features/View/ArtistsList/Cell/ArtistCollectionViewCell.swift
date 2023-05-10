//
//  ArtistCollectionViewCell.swift
//  Appcent-Case-Study
//
//  Created by Enes Talha Yılmaz on 9.05.2023.
//

import UIKit

final class ArtistCollectionViewCell: UICollectionViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func uiSetup(){
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.6
       }
    func configure(artist: Artist, isSelected: Bool) {
        uiSetup()
        titleLabel.text = artist.name
        if let image = artist.pictureMedium
        {
            if let imageUrl = URL(string: image) {
                imageView.kf.setImage(with: imageUrl)
            }
        }
        
    }
    static let nibName = "ArtistCollectionViewCell"

}
