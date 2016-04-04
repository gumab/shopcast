//
//  CommonModules.swift
//  ShopCast
//
//  Created by guma on 2016. 2. 15..
//  Copyright © 2016년 Guma. All rights reserved.
//

import Foundation
typealias ServiceResponse = (NSDictionary, NSError?) -> Void


class RestApiManager{
    static let sharedInstance = RestApiManager()
    
    func makeHTTPGetRequest(path: String, onCompletion:(NSDictionary, NSError?) -> Void) {
        let configuration = NSURLSessionConfiguration .defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration)
        
        let urlString = NSString(format: path)
        
        print("get wallet balance url string is \(urlString)")
        //let url = NSURL(string: urlString as String)
        let request : NSMutableURLRequest = NSMutableURLRequest()
        request.URL = NSURL(string: NSString(format: "%@", urlString) as String)
        request.HTTPMethod = "GET"
        request.timeoutInterval = 30
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var responseData:NSDictionary = NSDictionary()
        
        let dataTask = session.dataTaskWithRequest(request) {
            (let data: NSData?, let response: NSURLResponse?, let error: NSError?) -> Void in
            
            // 1: Check HTTP Response for successful GET request
            guard let httpResponse = response as? NSHTTPURLResponse, receivedData = data
                else {
                    print("error: not a valid http response")
                    return
            }
            
            switch (httpResponse.statusCode)
            {
            case 200:
                
                let response = NSString (data: receivedData, encoding: NSUTF8StringEncoding)
                print("response is \(response)")
                
                
                do {
                    responseData = try NSJSONSerialization.JSONObjectWithData(receivedData, options: .AllowFragments) as! NSDictionary
                    
                    //EZLoadingActivity .hide()
                    
                    // }
                } catch {
                    print("error serializing JSON: \(error)")
                }
                onCompletion(responseData, error)
                
                break
            case 400:
                
                break
            default:
                print("wallet GET request got response \(httpResponse.statusCode)")
            }
        }
        dataTask.resume()
    }
}