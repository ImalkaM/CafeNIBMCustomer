//
//  RegisterViewController.swift
//  CafeNIBMCustomer
//
//  Created by Imalka Muthukumara on 2021-04-11.
//

import UIKit
import Firebase
import Loaf

class RegisterViewController: UIViewController {
    
    let db = Firestore.firestore()
    var ref: DatabaseReference!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTextFieldSizeSetup()
        ref = Database.database().reference()
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        
        
        if !FieldValidator.isValidEmail(emailTextField.text ?? ""){
            Loaf("Invalid email address", state: .error, sender: self).show()
            return
        }
        
        
        if !FieldValidator.isValidPassword(pass: passwordTextField.text ?? "", minLength: 8, maxLength: 20){
            
            Loaf("Invalid password", state: .error, sender: self).show()
            return
            
        }
        if !FieldValidator.isValidMobileNo(phoneTextField.text ?? ""){
            
            Loaf("Invalid mobile no", state: .error, sender: self).show()
            return
            
        }
        registerUser(email: emailTextField.text!, password: passwordTextField.text!)
    }
    
    func registerUser(email:String,password:String){
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let err =  error{
                Loaf("\(err.localizedDescription)", state: .error, sender: self).show()
            }
            else{
                let user = User(name: self.userNameField.text!, email: self.emailTextField.text!, password: self.passwordTextField.text!, phonenumber: self.phoneTextField.text!)
                self.createUser(user: user)
            }
        }
    }
    func createUser(user:User){
        
        let userData = [
            "userName" : user.name,
            "userEmail" : user.email,
            "userPhone" : user.phonenumber,
            "userPassword" : user.password,
        ]
        self.ref.child("users").child(user.email
                                        .replacingOccurrences(of: "@", with: "_")
                                        .replacingOccurrences(of: ".", with: "_")
        ).setValue(userData){ (error, ref) in
            if let err =  error{
                Loaf("\(err.localizedDescription)", state: .error, sender: self).show()
            }
            else{
                Loaf("User Registered successfully", state: .success, sender: self).show()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func registerTextFieldSizeSetup(){
        emailTextField.addConstraint(emailTextField.heightAnchor.constraint(equalToConstant: 50))
        emailTextField.addConstraint(emailTextField.widthAnchor.constraint(equalToConstant: 270))
        
        phoneTextField.addConstraint(phoneTextField.heightAnchor.constraint(equalToConstant: 50))
        phoneTextField.addConstraint(phoneTextField.widthAnchor.constraint(equalToConstant: 270))
        
        passwordTextField.addConstraint(passwordTextField.heightAnchor.constraint(equalToConstant: 50))
        passwordTextField.addConstraint(passwordTextField.widthAnchor.constraint(equalToConstant: 270))
        
        
        signUpButton.layer.cornerRadius = 25
        signUpButton.addConstraint(signUpButton.heightAnchor.constraint(equalToConstant: 50))
        
    }
    
}
