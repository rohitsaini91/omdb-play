//
//  PosterCell.swift
//  OMDBPlay
//
//  Created by Rohit Saini on 11/01/20.
//  Copyright © 2020 Rohit Saini. All rights reserved.
//

import UIKit

class PosterCell: UICollectionViewCell {

    @IBOutlet weak var agoView: UIView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var posterPic: UIImageView!
    @IBOutlet weak var yearsAgoLbl: UILabel!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    
    //setting the poster data
    var posterData: Search!{
        didSet{
            posterPic.sainiTapToChangeColor()
            typeView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            agoView.sainiTapToChangeColor()
            posterPic.downloadCachedImage(placeholder: "", urlString: posterData.poster)
            titleLbl.text = posterData.title
            typeLbl.text = posterData.type
            yearsAgoLbl.text = yearAgo(year: posterData.year)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configUI()
    }
    
    
    //MARK:-configUI
    //configuring the cell ui
    private func configUI(){
        posterPic.layer.cornerRadius = 10
        typeView.layer.cornerRadius = 10
        overlayView.layer.cornerRadius = 10
        agoView.layer.cornerRadius = 10
        typeView.sainiRotateByAngle(angle: 90)
        agoView.sainiRotateByAngle(angle: 90)
        
        if #available(iOS 11.0, *) {
            typeView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
            posterPic.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
            overlayView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        
    }
}
