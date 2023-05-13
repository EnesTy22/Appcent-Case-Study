import UIKit
import Kingfisher

final class CategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    func uiSetup(){
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.6
       }
    
    func configure(genre: Genre) {
        uiSetup()
        titleLabel.text = genre.name
        if let image = genre.pictureMedium{
            if let imageUrl = URL(string: image) {
                imageView.kf.setImage(with: imageUrl)
            }
        }
        
    }
    
}
