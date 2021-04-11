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
    
    var foodItemArray:[FoodItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        foodTable.register(UINib(nibName: K.nibNameFoodTable, bundle: nil), forCellReuseIdentifier: K.foodTableCell)
        
        ref = Database.database().reference()
        
        getFoodDetails()
    }
}

extension FoodViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.FoodTableToFoodDetailsSeauge, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let foodDescriptionViewController = segue.destination as! FoodDescriptionViewController
        
        if let indexPath = foodTable.indexPathForSelectedRow {
            
            foodDescriptionViewController.setupFoodDescritionView(foodItem: foodItemArray[indexPath.row])
        }
    }
    
}

extension FoodViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.foodTableCell, for: indexPath) as! FoodTableViewCell
        
        cell.setupView(foodItem: foodItemArray[indexPath.row])
        
        return cell
    }
    
    
}
extension FoodViewController{
    
    func getFoodDetails(){
        ref.child("foodItems").observe(.value, with: {snapshot in
        
            if let data = snapshot.value{
                if let fooditems = data as? [String: Any]{
                    for items in fooditems{
                        if let foodInfo = items.value as? [String: Any] {
                            
                            let singleFoodItem = FoodItem(id: "",
                                                          foodName: foodInfo["name"] as! String,
                                                          foodDescription: foodInfo["description"] as! String,
                                                          category: foodInfo["category"] as! String,
                                                          foodPrice: foodInfo["price"] as! Double,
                                                          discount: foodInfo["discount"] as! Int,
                                                          image: foodInfo["image"] as! String)
                            
                            self.foodItemArray.append(singleFoodItem)
                            print(singleFoodItem)
                        }
                    }
                    
                    self.foodTable.reloadData()
                }
            }
        })
    }
}
