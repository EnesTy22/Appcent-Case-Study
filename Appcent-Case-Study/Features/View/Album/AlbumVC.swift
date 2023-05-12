//
//  AlbumVC.swift
//  Appcent-Case-Study
//
//  Created by Enes Talha Yılmaz on 10.05.2023.
//

import UIKit
import AVFoundation

final class AlbumVC: UIViewController {
    @IBOutlet var tableView: UITableView!{
        didSet{
            tableView.register(UINib(nibName: AlbumTableViewCell.identifier, bundle: nil),forCellReuseIdentifier: AlbumTableViewCell.identifier)
            tableView.allowsMultipleSelection = false
                tableView.allowsSelection = true
            tableView.allowsSelectionDuringEditing = true

            
        }
    }
    
    let viewModel = AlbumVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        Loader.shared.open(on: view)
        bind()
        tableView.delegate = self
        tableView.dataSource = self
        
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
    }}
    
private extension AlbumVC{
    func bind(){
        allTracksbind()
        reloadBind()
        
    }
    func reloadBind(){
        CoreService.shared?.reloadPage.subscribe { [weak self] _ in
            //self?.tableView.reloadData()
        }.disposed(by: viewModel.disposeBag)
    }
    func allTracksbind(){
        viewModel.allTracks
            .subscribe {[weak self] response in
                self?.tableView.reloadData()
                if response.element?.count != 0{
                    Loader.shared.close()

                }
            }.disposed(by: viewModel.disposeBag)
    }
}


