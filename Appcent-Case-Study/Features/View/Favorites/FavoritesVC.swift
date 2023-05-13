//
//  FavoritesVC.swift
//  Appcent-Case-Study
//
//  Created by Enes Talha Yılmaz on 8.05.2023.
//

import UIKit
import Lottie

final class FavoritesVC: UIViewController {
    
    let viewModel = FavoritesVM()
    var emptyAnimationView : LottieAnimationView?
    
    @IBOutlet var tableView: UITableView!{
        didSet{
            tableView.register(UINib(nibName: FavoritesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: FavoritesTableViewCell.identifier)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bringEmptyAnim()
        self.title = "My Favorites"
        bind()
        tableView.delegate = self
        tableView.dataSource = self
    }
    private func bringEmptyAnim(){
        if  emptyAnimationView == nil{
            emptyAnimationView = .init(name: "FavoritesEmpty")
            emptyAnimationView?.frame = view.bounds
            
            view.addSubview(emptyAnimationView!)
            emptyAnimationView?.alpha = 0

            emptyAnimationView?.loopMode = .loop
            emptyAnimationView?.play()

            // Animasyonlu nesnenin görünürlüğünü yavaşça artırır
            UIView.animate(withDuration: 3.0) {
                self.emptyAnimationView?.alpha = 1.0
            }
        }
        
       
    }
}

extension FavoritesVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(viewModel.allFavoriteTrackId.value.count == 0){
            bringEmptyAnim()
        }
        else{
            emptyAnimationView?.removeFromSuperview()
            emptyAnimationView = nil
        }
        
        return viewModel.allFavoriteTrackId.value.count
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
