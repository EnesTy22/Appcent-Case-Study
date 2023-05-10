//
//  ArtistDetailVC.swift
//  Appcent-Case-Study
//
//  Created by Enes Talha Yılmaz on 9.05.2023.
//

import UIKit
import RxSwift
import RxCocoa
class ArtistDetailVC: UIViewController {
    
    let viewModel = ArtistDetailVM()
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var tableView: UITableView!{
        didSet{
        
            tableView.register(UINib(nibName: ArtistDetailTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ArtistDetailTableViewCell.identifier)

        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }

}
private extension ArtistDetailVC{
    private func bind(){
        albumBind()
    }
    private func albumBind(){
        viewModel.albums
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] album in
                print(album.element?.count)
                self?.tableView?.reloadData()
            }.disposed(by: viewModel.disposeBag)
        viewModel.artist
            .observe(on: MainScheduler.instance)
            .compactMap{$0}
            .subscribe { [weak self] response in
                if let image = response.pictureMedium
                {
                    if let imgUrl = URL(string: image)
                    {
                        self?.imgView.kf.setImage(with:imgUrl)
                    }
                }
                
                self?.title = response.name

            }
    }
}
extension ArtistDetailVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let albumVC = AlbumVC(nibName: AlbumVC.identifier, bundle: nil) as AlbumVC
        albumVC.viewModel.artist.accept(viewModel.artist.value)
        albumVC.viewModel.album
            .accept(viewModel.albums.value[indexPath.row])
        navigationController?.pushViewController(albumVC, animated: true)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.albums.value.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:ArtistDetailTableViewCell.identifier,for: indexPath) as? ArtistDetailTableViewCell
        else{
         return UITableViewCell()
        }
        cell.Configure(album: viewModel.albums.value[indexPath.row])
        
        return cell

    }
    
    
}
