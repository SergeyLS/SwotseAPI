//
//  AuthorizationManager.swift
//  SwotseAPI
//
//  Created by Sergey Leskov on 6/1/17.
//  Copyright © 2017 Sergey Leskov. All rights reserved.
//

import Foundation
import Alamofire

class AuthorizationManager {
    
    //login
    static func login(userName: String, password: String, completion: @escaping (_ error: String?) -> Void)  {
        
        let parameters = [
            "username": userName,
            "password": password,
            ]
        
        let req = request(ConfigAPI.serverIP + ConfigAPI.loginURL, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        
        req.responseJSON { response in
            if response.result.isFailure  {
                completion(response.result.error! as? String)
            }
            
            guard let responseJSON = response.result.value as? [String: AnyObject] else {
                completion("Invalid tag information received from service")
                return
            }
            
            //            if (Array(responseJSON.keys).contains("non_field_errors")) == true {
            //                let err = responseJSON["non_field_errors"] as! String
            //                completion(err , nil)
            //                return
            //            }
            
            if (Array(responseJSON.keys).contains("key")) == true {
                AppDataManager.shared.userName = userName
                AppDataManager.shared.userToken = responseJSON["key"] as? String
                completion(nil)
                return
            }
            
            debugPrint(responseJSON)
            
            
            completion("Error login")
            
        }
    }
    
    
    //registration
    static func registration(userName: String, eMail: String, password: String, completion: @escaping (_ error: String?) -> Void)  {
        
        let parameters = [
            "username": userName,
            "password": password,
            "email": eMail
        ]
        
        let req = request(ConfigAPI.serverIP + ConfigAPI.registrationURL, method: .post, parameters: parameters, encoding: JSONEncoding.default)
        
        req.responseJSON { response in
            if response.result.isFailure  {
                //print(response.result.error!)
                completion(response.result.error! as? String)
            }
            
            guard let responseJSON = response.result.value as? [String: AnyObject] else {
                completion("Invalid tag information received from service")
                return
            }
            
            if (Array(responseJSON.keys).contains("message")) == true {
                let err = responseJSON["message"] as! String
                completion(err + ". Use login window")
                return
            }
            
            if (Array(responseJSON.keys).contains("token")) == true {
                AppDataManager.shared.userName = userName
                AppDataManager.shared.userToken = responseJSON["token"] as? String
                completion(nil)
                return
            }
            
            
            completion("Error")
            
        }
    }
    
    
    
}



