//
//  AlbumVC.swift
//  Appcent-Case-Study
//
//  Created by Enes Talha Yılmaz on 10.05.2023.
//

import UIKit
import AVFoundation
final class AlbumVC: UIViewController {
    var player :AVPlayer?
    @IBOutlet var tableView: UITableView!{
        didSet{
            tableView.register(UINib(nibName: AlbumTableViewCell.identifier, bundle: nil),forCellReuseIdentifier: AlbumTableViewCell.identifier)
            tableView.allowsMultipleSelection = false
                tableView.allowsSelection = true
            
        }
    }
    
    let viewModel = AlbumVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        tableView.delegate = self
        tableView.dataSource = self
        
        /*
        DeezerService.shared.request(path: DeezerServicePath.selectedAlbumPath(artistId: "8354140", albumId: "168136152")) {  (selectedGenre:TrackDatas) in
            print(DeezerServicePath.selectedAlbumPath(artistId: "8354140", albumId: "168136152"))
           print(selectedGenre)
        } onFail: { error in
            print(error)
            print(DeezerServicePath.selectedAlbumPath(artistId: "8354140", albumId: "168136152"))

        }*/
        
    }
}
extension AlbumVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allTracks.value.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? AlbumTableViewCell {
            cell.playBtnClicked(isPlaying: true)
                }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? AlbumTableViewCell {
            cell.playBtnClicked(isPlaying: false)
                }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as? AlbumTableViewCell else
        {
            return UITableViewCell()
        }
        self.title = viewModel.album.value?.title ?? "Unknown Album"
        cell.configure(track: viewModel.allTracks.value[indexPath.row],album: viewModel.album.value)
        return cell
        //viewModel.allTracks.value
    }}
    
extension AlbumVC{
    private func bind(){
        allTracksbind()
    }
    private func allTracksbind(){
        viewModel.allTracks
            .subscribe {[weak self] response in
                self?.tableView.reloadData()
            }.disposed(by: viewModel.disposeBag)
    }
}


