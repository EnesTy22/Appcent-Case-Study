//
//  FavoritesVC.swift
//  Appcent-Case-Study
//
//  Created by Enes Talha Yılmaz on 8.05.2023.
//

import UIKit
import Lottie

final class FavoritesVC: UIViewController {

    var animationView : LottieAnimationView?
    
    @IBOutlet var tableView: UITableView!{
        didSet{
            tableView.register(UINib(nibName: FavoritesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: FavoritesTableViewCell.identifier)
        }
    }
    
    let viewModel = FavoritesVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension FavoritesVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.allFavoriteTrackId.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier, for: indexPath) as? FavoritesTableViewCell else{return UITableViewCell()}
        cell.reloadConfigure(favoriteVC: self, trackId: viewModel.allFavoriteTrackId.value[indexPath.row], trackCover: viewModel.allFavoriteTrackCover.value[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FavoritesTableViewCell {
            cell.playBtnClicked(isPlaying: true)
                }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FavoritesTableViewCell {
            cell.playBtnClicked(isPlaying: false)
                }
    }
    
    
}

private extension FavoritesVC{
    
    func bind(){
        allFavBind()
    }
    
    func allFavBind(){
        viewModel
            .allFavoriteTrackId.subscribe {[weak self] response in
                self?.tableView.reloadData()
                
            }.disposed(by: viewModel.disposeBag)
        viewModel
            .allFavoriteTrackCover.subscribe {[weak self] response in
                self?.tableView.reloadData()
            }.disposed(by: viewModel.disposeBag)
    }
    
    
}
