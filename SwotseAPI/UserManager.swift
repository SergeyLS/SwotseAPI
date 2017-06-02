//
//  UserManager.swift
//  SwotseAPI
//
//  Created by Sergey Leskov on 6/1/17.
//  Copyright © 2017 Sergey Leskov. All rights reserved.
//

import Foundation
import CoreData
import Alamofire

class UserManager {
    
    static func getUserById(id: Int) -> User? {
        
        if id == 0 { return nil }
        
        let request = NSFetchRequest<User>(entityName: User.type)
        let predicate = NSPredicate(format: "id == %i", id)
        request.predicate = predicate
        
        let resultsArray = (try? CoreDataManager.shared.viewContext.fetch(request))
        
        return resultsArray?.first ?? nil
    }
    
    
    static func updateUser(user: User, dictionary: NSDictionary) {
        
        if let  lastLoginString = dictionary["last_login"] as? String {
            user.lastLogin = DateManager.datefromString(string: lastLoginString)
        }

        if let userName = dictionary["username"] as? String {
            user.userName = userName
        }

    }
    
    
    //allUsers
    static func getAllUsers( completion: @escaping (_ error: String?) -> Void)  {
        
        //        var headers = HTTPHeaders()
        //        headers.updateValue(AppDataManager.shared.userToken!, forKey: "Authorization")
        //
        //        let Auth_header    = [ "Authorization" : AppDataManager.shared.userToken ]
        
        //let token = "Token " + AppDataManager.shared.userToken!
        let token = "123"
        
        let headers: HTTPHeaders = [
            "name": AppDataManager.shared.userName!,
            "value": token
        ]
        
        let req = request(ConfigAPI.serverIP + ConfigAPI.allUsers, method: .get, encoding: JSONEncoding.default, headers: headers)
        
        req.responseJSON { response in
            
            // debugPrint(response)
            
            if response.result.isFailure  {
                //print(response.result.error!)
                completion(response.result.error! as? String)
            }
            
            guard let resultDict = response.result.value as? [NSDictionary] else {
                completion("Invalid tag information received from service")
                return
            }
 
            
            let moc = CoreDataManager.shared.newBackgroundContext
            moc.perform{ [weakMoc = moc] in
                for  element in resultDict {
                    guard
                        let  id = element["id"] as? Int

                        else {
                            print("error - id")
                            continue
                    }
                    
                    guard
                        let  userName = element["username"] as? String
                        
                        else {
                            print("error - userName")
                            continue
                    }
                    
                    if userName == "" {
                        print("userName id = \(id) - empfy, continue")
                        continue
                     }

                    
                    if let user = getUserById(id: id)  {
                        //update
                        updateUser(user: user, dictionary: element)
                     } else {
                        // New
                        guard let _ = User.entity(dictionary: element, context: weakMoc) else {
                            print("Error: Could not create a new User from API.")
                            continue
                        }
                        
                    } //else
                    
                } //for  element in popularDict
                
                CoreDataManager.shared.save(context: weakMoc)
                completion(nil)
            }

            
            
        }
        
    }
    
}
