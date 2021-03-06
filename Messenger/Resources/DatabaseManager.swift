//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Éder Barreto on 24/01/22.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    
}

// MARK: - Account Management

extension DatabaseManager {
    
    public func userExists(with email: String,
                           completion: @escaping ((Bool) -> Void)) {
        database.child(email).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
        })
        
    }
    
    /// Inserts new user to database
    public func insertUser(with user: ChaAppUser) {
        database.child(user.emailAddress).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }
}

struct ChaAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    //let profilePictureUrl: String
}
