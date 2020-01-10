//
//  Utility.swift
//  OMDBPlay
//
//  Created by Rohit Saini on 10/01/20.
//  Copyright © 2020 Rohit Saini. All rights reserved.
//

import UIKit
import SDWebImage
import SainiUtils


//MARK:- UIImageView
extension UIImageView{
    func downloadCachedImage(placeholder: String,urlString: String){
        log.inprocess("Media downloading started...")/
        log.info("mediaUrl: \(urlString)")/
        self.sainiShowLoader(loaderColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        let options: SDWebImageOptions = [.scaleDownLargeImages, .continueInBackground, .avoidAutoSetImage]
        let placeholder = UIImage(named: placeholder)
        self.sd_setImage(with: URL(string: urlString), placeholderImage: placeholder, options: options) { (image, _, cacheType, _) in
            self.sainiRemoveLoader()
            guard image != nil else {
                self.sainiRemoveLoader()
                log.warning("No media found!")/
                return
            }
            guard cacheType != .memory, cacheType != .disk else {
                self.image = image
                self.sainiRemoveLoader()
                log.success("Media Downloaded Successfully from servers")/
                return
            }
            UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.sainiRemoveLoader()
                self.image = image
                log.success("Media Cached from memory")/
                return
            }, completion: nil)
        }
    }
}
