//
//  APIHelper.swift
//  OMDBPlay
//
//  Created by Rohit Saini on 10/01/20.
//  Copyright © 2020 Rohit Saini. All rights reserved.
//


import UIKit

//MARK: - API
struct API {
    static let endPoint = "http://www.omdbapi.com/?s=Batman&page=1&apikey=eeefc96f"
}

//MARK:- GCD
//MultiThreading
struct GCD{
    struct THREAD{
        static let posterList = DispatchQueue(label: "com.app.OMDBPlay_posterList", attributes: DispatchQueue.Attributes.concurrent) //1
    }
}


