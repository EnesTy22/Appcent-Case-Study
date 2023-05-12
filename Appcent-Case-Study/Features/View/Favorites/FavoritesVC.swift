//
//  FavoritesVC.swift
//  Appcent-Case-Study
//
//  Created by Enes Talha Yılmaz on 8.05.2023.
//

import UIKit

final class FavoritesVC: UIViewController {

    @IBOutlet var tableView: UITableView!{
        didSet{
            tableView.register(UINib(nibName: FavoritesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: FavoritesTableViewCell.identifier)
        }
    }
    private let viewModel = FavoritesVM()
    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.viewModel.trackCover = viewModel.allFavoriteTrackCover.value[indexPath.row]
        cell.viewModel.trackId.accept(viewModel.allFavoriteTrackId.value[indexPath.row])

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
    private func bind(){
        allFavBind()
    }
    private func allFavBind(){
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
