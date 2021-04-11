//
//  LoginViewController.swift
//  CafeNIBMCustomer
//
//  Created by Imalka Muthukumara on 2021-04-11.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTextFieldSizeSetup()
        
    }
    
    func registerTextFieldSizeSetup(){
        emailAddressField.addConstraint(emailAddressField.heightAnchor.constraint(equalToConstant: 50))
        emailAddressField.addConstraint(emailAddressField.widthAnchor.constraint(equalToConstant: 270))
        
        passwordField.addConstraint(passwordField.heightAnchor.constraint(equalToConstant: 50))
        passwordField.addConstraint(passwordField.widthAnchor.constraint(equalToConstant: 270))
       
        
        loginButton.layer.cornerRadius = 25
        loginButton.addConstraint(loginButton.heightAnchor.constraint(equalToConstant: 50))
        
    }
}
