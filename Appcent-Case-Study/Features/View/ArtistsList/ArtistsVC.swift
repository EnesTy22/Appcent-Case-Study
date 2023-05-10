//
//  ArtistListVC.swift
//  Appcent-Case-Study
//
//  Created by Enes Talha Yılmaz on 9.05.2023.
//

import UIKit
import RxSwift

final class ArtistsVC: UIViewController {
    
    var artistVM = ArtistsVM()
    
    
    @IBOutlet var collectionView: UICollectionView!{
        didSet{
            
            collectionView.register(UINib(nibName: ArtistCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ArtistCollectionViewCell.identifier)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

private extension ArtistsVC{
    func bind(){
        genreBind()
        artistListBind()
    }
    func artistListBind(){
        artistVM.AllArtist.observe(on: MainScheduler.instance)
            .subscribe { [weak self] _ in
                self?.collectionView.reloadData()
                

            }.disposed(by: artistVM.disposeBag)
    }
    func genreBind(){
        artistVM.genre.observe(on: MainScheduler.instance)
            .subscribe { [weak self] genre in
                self?.title = genre.element??.name
            }.disposed(by: artistVM.disposeBag)
    }
}

extension ArtistsVC : UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        artistVM.AllArtist.value.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let artistDetailVC = ArtistDetailVC(nibName: "ArtistDetailVC", bundle: nil) as ArtistDetailVC
        artistDetailVC.viewModel.artist.accept(artistVM.AllArtist.value[indexPath.row])
        navigationController?.pushViewController(artistDetailVC, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtistCollectionViewCell.identifier, for: indexPath) as? ArtistCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(artist: artistVM.AllArtist.value[indexPath.row], isSelected: true)
        return cell
    }
    
    
}
