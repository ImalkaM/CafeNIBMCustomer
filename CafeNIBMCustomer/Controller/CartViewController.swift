//
//  CartViewController.swift
//  CafeNIBMCustomer
//
//  Created by Imalka Muthukumara on 2021-04-12.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func purchaseButtontapped(_ sender: UIButton) {
    }
    
}

extension CartViewController:UITableViewDelegate{
    
}

//extension CartViewController:UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//    
//    
//}
