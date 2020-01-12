//
//  PosterDetailsVC.swift
//  OMDBPlay
//
//  Created by Rohit Saini on 10/01/20.
//  Copyright © 2020 Rohit Saini. All rights reserved.
//

import UIKit

class PosterDetailsVC: UIViewController {
    
    

    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var releaseDataLbl: UILabel!
    @IBOutlet weak var posterTitle: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var posterPic: UIImageView!
    
    
    var posterDetailsData: Search!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        // Do any additional setup after loading the view.
    }
    
    
    private func configUI(){
        typeView.layer.cornerRadius = 10
        typeView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        posterPic.downloadCachedImage(placeholder: "", urlString: posterDetailsData.poster)
        posterTitle.text = posterDetailsData.title
        typeLbl.text = posterDetailsData.type
        releaseDataLbl.text = posterDetailsData.year
        idLbl.text = posterDetailsData.imdbID
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
