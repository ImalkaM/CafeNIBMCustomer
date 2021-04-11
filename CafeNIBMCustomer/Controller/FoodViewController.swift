//
//  FoodViewController.swift
//  CafeNIBMCustomer
//
//  Created by Imalka Muthukumara on 2021-04-11.
//

import UIKit

class FoodViewController: UIViewController {

    @IBOutlet weak var foodTable: UITableView!
    
    
    var foodItem:[FoodItem] = [FoodItem(id: "001", foodName: "Burger", foodDescription: "Chicken Burger", foodPrice: 300.00, discount: 10, image: "burger"),
                               FoodItem(id: "002", foodName: "Taco", foodDescription: "Chicken Taco", foodPrice: 250.00, discount:0, image: "taco"),
                               FoodItem(id: "003", foodName: "shawarma", foodDescription: "Vegitable Shawarma", foodPrice: 250.00, discount: 0, image: "shawarma"),
                               FoodItem(id: "004", foodName: "Kottu", foodDescription: "Chicken cheese kottu", foodPrice: 450.00, discount: 20, image: "kottu")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        foodTable.register(UINib(nibName: K.nibNameFoodTable, bundle: nil), forCellReuseIdentifier: K.foodTableCell)
    }
    

}

extension FoodViewController: UITableViewDelegate{
    
}

extension FoodViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.foodTableCell, for: indexPath) as! FoodTableViewCell
        
        cell.setupView(foodItem: foodItem[indexPath.row])
        
        return cell
    }
    
    
}
