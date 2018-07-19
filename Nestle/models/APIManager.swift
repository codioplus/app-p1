//
//  APIManager.swift
//  Nestle
//
//  Created by User on 6/1/18.
//  Copyright © 2018 Nestle. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper
import PromiseKit
import ObjectMapper
class APIManager{
    let functions = Functions()
    static let shared = APIManager()
    
    private init(){
        
        
    }
   
    
    
    
    
    func fetchFamiliesApi() -> Promise<[Families]> {
        let momId : String? = KeychainWrapper.standard.string(forKey: "uid")
      
        
        let URL_GET_DATA = functions.apiLink()+"get_doctor_moms.json/"+momId!
      //  let urlAddressEscaped = URL_GET_DATA.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
       // let request = URLRequest(url: URL(string: urlAddressEscaped!)!, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 20)
        return Promise<[Families]>{
           resolver in

            
        
            
            
//            let cachedURLResponse = CachedURLResponse(response: response.response!, data: (response.data! as NSData) as Data, userInfo: nil, storagePolicy: .allowed)
//            URLCache.shared.storeCachedResponse(cachedURLResponse, for: response.request!)
//
            
            Alamofire.request(URL_GET_DATA).responseJSON {
                response in
                switch(response.result){
                    
                case .success:
        let responseJSON = response.result.value as? Array<[String: AnyObject]>
             //   let responseJSON = JSON(cachedURLResponse.data).arrayObject as? Array<[String: AnyObject]>
               // let responseJSON = response.result.value as? Array<[String: AnyObject]>
                let families : [Families] = Mapper<Families>().mapArray(JSONArray: responseJSON!)
        
                 resolver.fulfill(families)

                case .failure(let error):
                    
                    print(error)
                    resolver.reject(error)
                }
                
            }
            
        }
       
    }
    
    
    
    func fetchShoutMotherApi() -> Promise<[Shoutout]> {
        let doctorId : String? = KeychainWrapper.standard.string(forKey: "doctor_id")
        
        let URL_GET_DATA = functions.apiLink()+"get_doctor_shoutout.json/"+doctorId!
        
        return Promise<[Shoutout]>{
            resolver in
            Alamofire.request(URL_GET_DATA).responseJSON {
                response in
                
                switch(response.result){
                    
                case .success:
                    
                    let responseJSON = response.result.value as? Array<[String: AnyObject]>
                    
                    let shouty : [Shoutout] = Mapper<Shoutout>().mapArray(JSONArray: responseJSON!)
                    
                    resolver.fulfill(shouty)
                    
                case .failure(let error):
                    
                    print(error)
                    resolver.reject(error)
                }
                
            }
            
        }
        
    }
    
    func fetchChartApi(country: String, gender: String, type: String) -> Promise<[Chart]> {

        let URL_GET_DATA = functions.apiLink()+"apis/growth_chart.php?country="+country+"&gender="+gender+"&type="+type
        
        return Promise<[Chart]>{
            resolver in
            Alamofire.request(URL_GET_DATA).responseJSON {
                response in
                
                switch(response.result){
                    
                case .success:
                    
                    let responseJSON = response.result.value as? Array<[String: AnyObject]>
                    
                    let shoutout : [Chart] = Mapper<Chart>().mapArray(JSONArray: responseJSON!)
                    
                    resolver.fulfill(shoutout)
                    
                case .failure(let error):
                    
                    print(error)
                    resolver.reject(error)
                }
                
            }
            
        }
        
    }
    
    func fetchShoutApi() -> Promise<[Shoutout]> {
        let momId : String? = KeychainWrapper.standard.string(forKey: "uid")
        
        let URL_GET_DATA = functions.apiLink()+"get_doctor_shoutout.json/"+momId!
        
        return Promise<[Shoutout]>{
            resolver in
            Alamofire.request(URL_GET_DATA).responseJSON {
                response in
                
                switch(response.result){
                    
                case .success:
                    
                    let responseJSON = response.result.value as? Array<[String: AnyObject]>
                    
                    let shoutout : [Shoutout] = Mapper<Shoutout>().mapArray(JSONArray: responseJSON!)
                    
                    resolver.fulfill(shoutout)
                    
                case .failure(let error):
                    
                    print(error)
                    resolver.reject(error)
                }
                
            }
            
        }
        
    }
    
}
