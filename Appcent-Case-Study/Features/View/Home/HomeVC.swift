import UIKit
import RxSwift
import RxCocoa

final class HomeVC: UIViewController {
    private let viewModel = HomeVM()

    @IBOutlet var collectionView: UICollectionView!{
        didSet {
        collectionView.register(UINib(nibName: CategoriesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
    }}
    override func viewDidLoad() {
        super.viewDidLoad()
        Loader.shared.open(on: view)
        bind()
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }


}

// MARK: Bindings.
private extension HomeVC {
    func bind() {
        labelBind()
    }
    
    func labelBind() {
        viewModel.allGenre
            .observe(on: MainScheduler.instance)
            .compactMap{$0}
            .subscribe { [weak self] allGenre in
                if allGenre.element?.count != 0{
                    Loader.shared.close()
                }
                self?.collectionView.reloadData()
            }
            .disposed(by: viewModel.disposeBag)
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
        self.title = "Deezer"
        cell.configure(genre: viewModel.allGenre.value[indexPath.row])
        return cell
    }
    
    
}
