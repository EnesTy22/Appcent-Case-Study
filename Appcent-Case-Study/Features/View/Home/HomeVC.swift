import UIKit
import RxSwift
import RxCocoa

final class HomeVC: UIViewController {
    private let viewModel = HomeVM()
    


    @IBOutlet var collectionView: UICollectionView!{
        didSet {
        collectionView.register(UINib(nibName: CategoriesCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: CategoriesCollectionViewCell.nibName)
    }}
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }


}

// MARK: Bindings.

private extension HomeVC {
    func bind() {
        labelBind()
        labelCountbind()
    }
    
    func labelBind() {
        viewModel.allGenre
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] allGenre in
                // self?.label.text = "\(allGenre.element?.count ?? 0)"
                self?.collectionView.reloadData()
            }
            .disposed(by: viewModel.disposeBag)
    }
    
    func labelCountbind() {
        
    }
}

// MARK: Collectionview Delegates

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.allGenre.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let artistsVC = ArtistsVC(nibName: "ArtistsVC", bundle: nil) as ArtistsVC
        artistsVC.artistVM.genre.accept(viewModel.allGenre.value[indexPath.row])
        navigationController?.pushViewController(artistsVC, animated: true)

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as? CategoriesCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(genre: viewModel.allGenre.value[indexPath.row], isSelected: true)
        return cell
    }
    
    
}
