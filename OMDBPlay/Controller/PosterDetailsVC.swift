//
//  PosterDetailsVC.swift
//  OMDBPlay
//
//  Created by Rohit Saini on 10/01/20.
//  Copyright © 2020 Rohit Saini. All rights reserved.
//

import UIKit

class PosterDetailsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var posterDetailsData: Search!
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
       
        // Do any additional setup after loading the view.
    }
    
    private func configUI(){
        tableView.register(UINib(nibName: "PosterDetailsCell", bundle: nil), forCellReuseIdentifier: "PosterDetailsCell")
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
    }
    
}


//MARK:- Tableview Delegate and Datasourece
extension PosterDetailsVC: UITableViewDelegate,UITableViewDataSource{
    // estimatedHeightForRowAt
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PosterDetailsCell", for: indexPath) as? PosterDetailsCell else{
            return UITableViewCell()
        }
        cell.posterDetailsData = posterDetailsData
        return cell
    }
}
