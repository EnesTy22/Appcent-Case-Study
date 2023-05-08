//
//  FavoritesVC.swift
//  Appcent-Case-Study
//
//  Created by Enes Talha Yılmaz on 8.05.2023.
//

import UIKit

class FavoritesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationController?.pushViewController(detailsVC, animated: true)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }

    @IBAction func btnClick(_ sender: Any) {
        let detailsVC = DetailsVC(nibName: "DetailsVC", bundle: nil)
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
