//
//  PosterListVC.swift
//  OMDBPlay
//
//  Created by Rohit Saini on 10/01/20.
//  Copyright © 2020 Rohit Saini. All rights reserved.
//

import UIKit

class PosterListVC: UIViewController,UICollectionViewDelegateFlowLayout {

    
    //OUTLETS
    @IBOutlet weak var collectionView: AutoLayoutCollectionView!
    private var postListingData: [Search] = [Search]()
    private var isLandscape: Bool = false
    
    //pagination variables
    private var totalPost: Int = 0
    private var page: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        posterListing(page: 1)
        // Do any additional setup after loading the view.
    }
    
    //MARK:- configUI
    private func configUI(){
        collectionView.register(UINib(nibName: "PosterCell", bundle: nil), forCellWithReuseIdentifier: "PosterCell")
        let flowLayout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = flowLayout
    }
    
    //Detecting the device orientation changes
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            log.success("Landscape")/
            isLandscape = true
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } else {
            log.success("Portrait")/
            isLandscape = false
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
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
        let apiEndPoint = "http://www.omdbapi.com/?s=Batman&page=\(page)&apikey=eeefc96f"
        GCD.THREAD.posterList.async {
            APIManager.sharedInstance.FetchPosterListingData(api: apiEndPoint, Loader: true) { [weak self](response) in
                if response != nil{                             //if response is not empty
                    do {
                        let result = try JSONDecoder().decode(PosterListModel.self, from: response!) // decode the response into success model
                        switch result.response{
                        case "True":
                            log.success("\(Log.stats()) poster listing fetched successfully!")/
                            self?.totalPost = Int(result.totalResults) ?? 0
                            self?.postListingData += result.search!
                            DispatchQueue.main.async {
                                self?.collectionView.reloadData()
                            }
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


//MARK:- CollectionView Delegate and Datasource methods
extension PosterListVC: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postListingData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as? PosterCell else{
            return UICollectionViewCell()
        }
        
        cell.posterData = postListingData[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc: PosterDetailsVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "PosterDetailsVC") as! PosterDetailsVC
        vc.posterDetailsData = postListingData[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
       
    }
    
    //PAGINATION
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        log.todo("POSTS: \(postListingData.count)")/
        //preloading
        if indexPath.row == postListingData.count - 2 && postListingData.count < totalPost{
            page = page + 1
            posterListing(page: page)
        }
    }
    //MARK: - collectionFlowViewLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellH : CGFloat = collectionView.frame.size.height - 10
        let cellW : CGFloat = collectionView.frame.size.width - 10
        if isLandscape{
            return CGSize(width: cellW / 2, height: cellH)
        }
        else{
            return CGSize(width: cellW / 2, height: cellH / 2)
        }
        
    }

}
