//
//  FirebaseAuth.swift
//  Appub
//
//  Created by Jake Renshaw on 21/06/2020.
//  Copyright © 2020 Jake Renshaw. All rights reserved.
//

import Foundation
import Firebase

class FirebaseAuth: NSObject {
    
    var handler: AuthStateDidChangeListenerHandle?
    
    override init() {
        super.init()
        self.addHandler()
    }
    
    func addHandler() {
        self.handler = Auth.auth().addStateDidChangeListener { (auth, user) in
            print("state changed")
            if let user = user {
                print("User = \(user)")
            }
            print("Auth = \(auth)")
        }
    }
    
    func createUser(email: String, password: String, completion: @escaping ((Error?) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            print("create user")
            if let authResult = authResult {
                print("auth result = \(authResult)")
                completion(nil)
            }
            if let error = error {
                completion(error)
                print("create user error = \(error)")
            }
        }
    }
    
    func signInUser(email: String, password: String, completion: @escaping ((Error?) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            print("sign in user")
            if let authResult = authResult {
                print("auth result = \(authResult)")
                completion(nil)
            }
            if let error = error {
                completion(error)
                print("sign in user error = \(error)")
            }
        }
    }
}
