//
//  CartViewController.swift
//  CafeNIBMCustomer
//
//  Created by Imalka Muthukumara on 2021-04-12.
//

import UIKit
import Firebase
import Loaf

class CartViewController: UIViewController {

    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var ref: DatabaseReference!
    
    let sessionMGR = SessionManager()
    
    var cartItems:[CartItem] = []
    
    var totalPrice:Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cartItems = CartHandler.getCartItems()
        cartTableView.register(UINib(nibName: K.nibNameCartTable, bundle: nil), forCellReuseIdentifier: K.cartTableCell)
        totalPriceLabel.text = String(calTotal())
        
        ref = Database.database().reference()
    }
    

    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func purchaseButtontapped(_ sender: UIButton) {
        
        saveOrder()
    }
    
}

extension CartViewController:UITableViewDelegate{
    
}

extension CartViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cartTableCell, for: indexPath) as! CartTableViewCell
        
        cell.name.text = cartItems[indexPath.row].itemName
        cell.foodImage.kf.setImage(with: URL(string: cartItems[indexPath.row].itemImgRes))
        cell.qtyLabel.text = String(cartItems[indexPath.row].itemCount)
        cell.price.text = "RS.\(String(cartItems[indexPath.row].itemTotal))"
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
    
}
extension CartViewController: CartItemDelegate {
    
    func plusButtonTapped(at indexPath: IndexPath) {
         self.cartItems[indexPath.row].itemCount += 1
        totalPrice = calTotal()
        totalPriceLabel.text = String(totalPrice)
         self.cartTableView.reloadData()
    }
    
    func minusButtontapped(at indexPath: IndexPath) {
        
        self.cartItems[indexPath.row].itemCount -= 1
        totalPrice = calTotal()
        totalPriceLabel.text = String(totalPrice)
        
        if cartItems[indexPath.row].itemCount == 0{
            cartItems.remove(at: indexPath.row)
            cartTableView.deleteRows(at: [indexPath], with: .fade)
            //orderDetails.remove(at: indexPath.row)
            
        }
        self.cartTableView.reloadData()
        
        
    }
    
    func calTotal() ->Double{
        var tempTotal:Double = 0.0
        for items in cartItems{
            tempTotal += items.itemTotal
            
        }
        
        return tempTotal
    }
}
extension CartViewController{
    
    func saveOrder(){
        
        var orderData: [String: Any] = [:]
        var foodItemInfo:[String:Any] = [:]
        
        for index in 0..<cartItems.count{
            foodItemInfo.removeAll()
            foodItemInfo["foodName"] = cartItems[index].itemName
            foodItemInfo["qunatity"] = cartItems[index].itemCount
            foodItemInfo["foodPrice"] = cartItems[index].itemTotal
            orderData["\(index)"] = foodItemInfo
        }
        
        var order:[String:Any] = [:]
        order["status"] = "Pending"
        order["orderItems"] = orderData
        
        self.ref.child("orders").child(sessionMGR.getUserData().email
                                        .replacingOccurrences(of: "@", with: "_")
                                        .replacingOccurrences(of: ".", with: "_")
         ).childByAutoId()
        .setValue(order){ (error, ref) in
            if let err =  error{
                Loaf("\(err.localizedDescription)", state: .error, sender: self).show()
            }
            else{
                Loaf("Order added successfully", state: .success, sender: self).show()
                CartHandler.clearCart()
                self.cartTableView.reloadData()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}


