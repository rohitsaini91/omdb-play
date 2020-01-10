//
//  PosterCell.swift
//  OMDBPlay
//
//  Created by Rohit Saini on 11/01/20.
//  Copyright © 2020 Rohit Saini. All rights reserved.
//

import UIKit

class PosterCell: UICollectionViewCell {

    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var posterPic: UIImageView!
    @IBOutlet weak var yearsAgoLbl: UILabel!
    @IBOutlet weak var imdbRatingLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    
    var posterData: Search!{
        didSet{
            posterPic.downloadCachedImage(placeholder: "", urlString: posterData.poster)
            titleLbl.text = posterData.title
            imdbRatingLbl.text = posterData.imdbID
            yearsAgoLbl.text = posterData.year
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configUI()
    }

    private func configUI(){
        posterPic.layer.cornerRadius = 10
        if #available(iOS 11.0, *) {
            posterPic.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        typeView.sainiCircle()
    }
}
