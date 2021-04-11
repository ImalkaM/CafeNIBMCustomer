//
//  LoginViewController.swift
//  CafeNIBMCustomer
//
//  Created by Imalka Muthukumara on 2021-04-11.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTextFieldSizeSetup()
        
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        
        if validateInput(){
            if let email = emailAddressField.text, let password = passwordField.text{
                auhtenticateUser(email: email, password: password)
            }
        }
        else{
            emailAddressField.text = ""
            emailAddressField.attributedPlaceholder = NSAttributedString(string: "Please check your Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            passwordField.text = ""
            passwordField.attributedPlaceholder = NSAttributedString(string: "Please check your Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        }
    }
    
    func validateInput() -> Bool{
        
        guard let email = emailAddressField.text else {
           
            return false
           
        }
        guard let password = passwordField.text else {
            
            return false
        }
        
        if email.count < 5{
           
            return false
        }
        if password.count < 8{
           
            return false
        }
        
        return true
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
                let alert = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
            else{
                print("login success")
            }
        }
    }
    
}
