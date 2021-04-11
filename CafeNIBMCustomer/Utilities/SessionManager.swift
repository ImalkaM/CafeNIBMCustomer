//
//  SessionManager.swift
//  CafeNIBMCustomer
//
//  Created by Imalka Muthukumara on 2021-04-11.
//

import Foundation


class SessionManager {
    
    let userDeafualts = UserDefaults()
    
    func saveUserLogin(){
        
        UserDefaults.standard.setValue(true, forKey: "Logged_IN")
    }
    
    func clearUserState(){
        
        UserDefaults.standard.setValue(false, forKey: "Logged_IN")
    }
    
    func getUserLoggedState()->Bool{
        
        return  UserDefaults.standard.bool(forKey: "Logged_IN")
         
    }
}
