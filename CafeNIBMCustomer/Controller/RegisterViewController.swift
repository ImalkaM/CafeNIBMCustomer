//
//  RegisterViewController.swift
//  CafeNIBMCustomer
//
//  Created by Imalka Muthukumara on 2021-04-11.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerTextFieldSizeSetup()
    }

    @IBAction func signInTapped(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        
        if validateFields(){
            if let email = emailTextField.text,let password = passwordTextField.text{
                registerUser(email: email, password: password)
                
                
            }
           
        }else{
            emailTextField.text = ""
            emailTextField.attributedPlaceholder = NSAttributedString(string: "Please check your Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            
            phoneTextField.text = ""
            phoneTextField.attributedPlaceholder = NSAttributedString(string: "Please check your Phonenumber", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            
            passwordTextField.text = ""
            passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password must ne 8  characters", attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        }
    }
    
    func registerUser(email:String,password:String){
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let err =  error{
                let alert = UIAlertController(title: "Error", message: err.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
            else{
                let alert = UIAlertController(title: "Success", message:"User Registered Success!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    func validateFields() ->Bool{
        
        if let email = emailTextField.text,let phoneNumber = phoneTextField.text,let password = passwordTextField.text{
            
            if email.count < 5{
               
                return false
            }
            if phoneNumber.count < 10{
               
                return false
            }
            if password.count < 8{
               
                return false
            }
            
            return true
        }
        
        return false
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
