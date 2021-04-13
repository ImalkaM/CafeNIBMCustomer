//
//  AccountViewController.swift
//  CafeNIBMCustomer
//
//  Created by Imalka Muthukumara on 2021-04-13.
//

import UIKit

class AccountViewController: UIViewController {
    
    let sessionMgr = SessionManager()
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = sessionMgr.getUserData()
        
        userName.text = user.name
        userEmail.text = user.email
        userPhone.text = user.phonenumber
    }

    @IBAction func signOutPressed(_ sender: UIButton) {
        
        sessionMgr.clearUserState()
        self.navigationController?.popToRootViewController(animated: false)
    }
    
}
