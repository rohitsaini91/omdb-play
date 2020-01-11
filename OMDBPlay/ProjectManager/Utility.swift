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
                log.success("Media Cached from memory")/
                
                return
            }
            UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.sainiRemoveLoader()
                self.image = image
                log.success("Media Downloaded Successfully from servers")/
                return
            }, completion: nil)
        }
    }
}


//MARK: - UIViewController
extension UIViewController {
    
    static var top: UIViewController? {
        get {
            return topViewController()
        }
    }
    
    static var root: UIViewController? {
        get {
            return UIApplication.shared.delegate?.window??.rootViewController
        }
    }
    
    static func topViewController(from viewController: UIViewController? = UIViewController.root) -> UIViewController? {
        if let tabBarViewController = viewController as? UITabBarController {
            return topViewController(from: tabBarViewController.selectedViewController)
        } else if let navigationController = viewController as? UINavigationController {
            return topViewController(from: navigationController.visibleViewController)
        } else if let presentedViewController = viewController?.presentedViewController {
            return topViewController(from: presentedViewController)
        } else {
            return viewController
        }
    }
}

//MARK:- Data
extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}

//MARK: - AutoLayoutCollectionView
class AutoLayoutCollectionView: UICollectionView {
  private var shouldInvalidateLayout = false
  override func layoutSubviews() {
    super.layoutSubviews()
    if shouldInvalidateLayout {
      collectionViewLayout.invalidateLayout()
      shouldInvalidateLayout = false
    }
  }
  override func reloadData() {
    shouldInvalidateLayout = true
    super.reloadData()
  }
}

//MARK:- yearAgo
public func yearAgo(year: String) -> String{
    let getYear = year.prefix(4)
    let releaseYear = Int(String(getYear)) ?? 0
    let date = Date()
    let calendar = Calendar.current
    let currentYear = calendar.component(.year, from: date)
    var yearAgoString = ""
    let yearsAgo = currentYear - releaseYear
    //ago
    if currentYear > releaseYear{
        yearAgoString = "\(yearsAgo) years ago."
    }
    //coming year
    else if currentYear < releaseYear{
        yearAgoString = "Coming Soon"
    }
    //this year
    else{
       yearAgoString = "This Year"
    }
    
    return yearAgoString
}
