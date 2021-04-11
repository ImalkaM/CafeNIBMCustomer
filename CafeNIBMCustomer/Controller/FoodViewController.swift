//
//  FoodViewController.swift
//  CafeNIBMCustomer
//
//  Created by Imalka Muthukumara on 2021-04-11.
//

import UIKit
import Firebase

class FoodViewController: UIViewController {
    
    var ref: DatabaseReference!

    @IBOutlet weak var foodTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        foodTable.register(UINib(nibName: K.nibNameFoodTable, bundle: nil), forCellReuseIdentifier: K.foodTableCell)
        
        ref = Database.database().reference()
    }
    

}

extension FoodViewController: UITableViewDelegate{
    
}

extension FoodViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.foodTableCell, for: indexPath) as! FoodTableViewCell
        
        //cell.setupView(foodItem: foodItem[indexPath.row])
        
        return cell
    }
    
    
}
