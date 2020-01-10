//
//  PosterListVC.swift
//  OMDBPlay
//
//  Created by Rohit Saini on 10/01/20.
//  Copyright © 2020 Rohit Saini. All rights reserved.
//

import UIKit

class PosterListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        posterListing(page: 1)
        // Do any additional setup after loading the view.
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

//MARK:- PosterListVC API's
extension PosterListVC{
    //MARK:- posterListing
    private func posterListing(page: Int){
        GCD.THREAD.posterList.async {
            APIManager.sharedInstance.FetchPosterListingData(api: API.endPoint, Loader: true) { (response) in
                if response != nil{                             //if response is not empty
                    do {
                        let result = try JSONDecoder().decode(PosterListModel.self, from: response!) // decode the response into success model
                        switch result.response{
                        case "True":
                            log.success("\(Log.stats()) poster listing fetched successfully!")/
                           
                            break
                        default:
                            log.error("\(Log.stats()) \(result.response)")/
                        }
                    }
                    catch let err {
                        log.error("ERROR OCCURED WHILE DECODING: \(Log.stats()) \(err)")/
                    }
                }
            }
        }
    }
}


