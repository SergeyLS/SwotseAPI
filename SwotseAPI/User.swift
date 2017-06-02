//
//  User+CoreDataClass.swift
//  SwotseAPI
//
//  Created by Sergey Leskov on 6/1/17.
//  Copyright © 2017 Sergey Leskov. All rights reserved.
//

import Foundation
import CoreData

public class User: NSManagedObject {

    //==================================================
    // MARK: - Stored Properties
    //==================================================
    
    static let type = "User"
    
    
    //==================================================
    // MARK: - Initializers
    //==================================================
    
    class func entity(dictionary: NSDictionary, context: NSManagedObjectContext) -> User? {
        guard let id = dictionary["id"] as? Int64,
            let userName = dictionary["username"] as? String
            //let lastLoginString = dictionary["last_login"] as? String
             else {
                return nil
        }
        
        if userName == "" {
            return nil
        }
        
        let resultEntity = User(context: context)
        
        

        
        resultEntity.id = id
        resultEntity.userName = userName
        
        if let  lastLoginString = dictionary["last_login"] as? String {
             resultEntity.lastLogin = DateManager.datefromString(string: lastLoginString)
         }

        
        print("add \(type): " + userName)
        
        return resultEntity;
    }

    
}
