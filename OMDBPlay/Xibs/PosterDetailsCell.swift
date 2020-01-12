//
//  PosterDetailsCell.swift
//  OMDBPlay
//
//  Created by Rohit Saini on 12/01/20.
//  Copyright © 2020 Rohit Saini. All rights reserved.
//

import UIKit

class PosterDetailsCell: UITableViewCell {

    
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var releaseDataLbl: UILabel!
    @IBOutlet weak var posterTitle: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var posterPic: UIImageView!
    @IBOutlet weak var imdbView: UIView!
    
    var posterDetailsData: Search!{
        didSet{
        posterPic.downloadCachedImage(placeholder: "", urlString: posterDetailsData.poster)
        posterTitle.text = posterDetailsData.title
        typeLbl.text = posterDetailsData.type
        releaseDataLbl.text = posterDetailsData.year
        idLbl.text = "IMDB ID: \(posterDetailsData.imdbID)"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configUI()
    }

    
    private func configUI(){
          typeView.layer.cornerRadius = 10
          typeView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
          imdbView.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
          imdbView.layer.cornerRadius = 10
          
      }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
