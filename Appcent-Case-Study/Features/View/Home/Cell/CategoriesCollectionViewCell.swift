import UIKit
import Kingfisher

final class CategoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
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
    
    func configure(genre: Genre, isSelected: Bool) {
        uiSetup()
        titleLabel.text = genre.name
        if let image = genre.pictureMedium{
            if let imageUrl = URL(string: image) {
                imageView.kf.setImage(with: imageUrl)
            }
        }
        
    }
    
}
