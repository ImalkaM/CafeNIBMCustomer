//
//  LoginViewController.swift
//  CafeNIBMCustomer
//
//  Created by Imalka Muthukumara on 2021-04-11.
//

import UIKit
import Firebase
import Loaf

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTextFieldSizeSetup()
        
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        
        if !FieldValidator.isValidEmail(emailAddressField.text ?? ""){
            Loaf("Invalid email address", state: .error, sender: self).show()
            return
        }
        
        
        if !FieldValidator.isValidPassword(pass: passwordField.text ?? "", minLength: 8, maxLength: 20){
            
            Loaf("Invalid password", state: .error, sender: self).show()
            return
            
        }
        
        auhtenticateUser(email: emailAddressField.text!, password: passwordField.text!)
    }
    func registerTextFieldSizeSetup(){
        emailAddressField.addConstraint(emailAddressField.heightAnchor.constraint(equalToConstant: 50))
        emailAddressField.addConstraint(emailAddressField.widthAnchor.constraint(equalToConstant: 270))
        
        passwordField.addConstraint(passwordField.heightAnchor.constraint(equalToConstant: 50))
        passwordField.addConstraint(passwordField.widthAnchor.constraint(equalToConstant: 270))
        
        
        loginButton.layer.cornerRadius = 25
        loginButton.addConstraint(loginButton.heightAnchor.constraint(equalToConstant: 50))
        
    }
    
    func auhtenticateUser(email:String,password:String){
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let err =  error{
                Loaf("\(err.localizedDescription)", state: .error, sender: self).show()
            }
            else{
                let sesssionManager = SessionManager()
                sesssionManager.saveUserLogin()
                self.performSegue(withIdentifier: K.loginToHomeSeauge, sender: self)
                
            }
        }
    }
    
}
