//
//  APIManager.swift
//  OMDBPlay
//
//  Created by Rohit Saini on 10/01/20.
//  Copyright © 2020 Rohit Saini. All rights reserved.
//

import Foundation
import SystemConfiguration
import Alamofire


//MARK:- APIManager
public class APIManager {
    
    static let sharedInstance = APIManager()
    
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    //MARK:- checkInternetConnection
    func checkInternetConnection() -> Bool{
        if !APIManager.isConnectedToNetwork(){
            return false
        }
        else{
            return true
        }
    }
    
    //network error message
    func networkErrorMsg()
    {
        log.error("You are not connected to the internet")/
        UIViewController.top?.view.sainiShowToast(message:"You are not connected to the internet")
    }
    
   
    

    //MARK:- FetchPosterListingData
    func FetchPosterListingData(api: String,Loader: Bool,_ completion: @escaping (_ dictArr: Data?) -> Void){
        if !APIManager.isConnectedToNetwork()
        {
            APIManager().networkErrorMsg()
            return
        }
        
        //showing loader
        if Loader == true{
            DispatchQueue.main.async {
                UIViewController.top?.view.sainiShowLoader(loaderColor: AppColors.LoaderColor)
            }
        }
        log.info("API: \(Log.stats()) \(api) Working on \(String(describing: DispatchQueue.currentLabel ?? "")) Thread")/
        Alamofire.request(api, method: .get).responseJSON { (response) in
            
            //remove  loader
            DispatchQueue.main.async {
                UIViewController.top?.view.sainiRemoveLoader()
            }
            
            switch response.result {
            //success reponse
            case .success:
                log.result("\(String(describing: response.result.value))")/
                log.ln("prettyJSON Start \n")/
                log.result("\(String(describing: response.data?.prettyPrintedJSONString))")/
                log.ln("prettyJSON End \n")/
                if let result = response.result.value as? [String:Any]{
                    if let code = result["Response"] as? String{
                        if(code == "True"){
                            log.success("\(Log.stats()) SUCCESS")/
                            DispatchQueue.main.async {
                                completion(response.data)
                            }
                            return
                        }
                        else{
                            if let message = result["Response"] as? String{
                                log.error("\(Log.stats()) \(message)")/
                                UIViewController.top?.view.sainiShowToast(message:message)
                            }
                            return
                        }
                    }
                    if let message = result["Response"] as? String{
                        log.error("\(Log.stats()) \(message)")/
                        UIViewController.top?.view.sainiShowToast(message:message)
                        return
                    }
                }
                if let error = response.result.error
                {
                    log.error("\(Log.stats()) \(error)")/
                    UIViewController.top?.view.sainiShowToast(message:error.localizedDescription)
                    return
                }
            //failure response
            case .failure(let error):
                log.error("\(Log.stats()) \(error)")/
                UIViewController.top?.view.sainiShowToast(message:"Server Error please check server logs.")
                break
            }
        }
    }
}
