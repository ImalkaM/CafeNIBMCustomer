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
    
    var cartItems:[CartItem] = []
    
    var totalPrice:Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.cartItems = CartHandler.getCartItems()
        cartTableView.register(UINib(nibName: K.nibNameCartTable, bundle: nil), forCellReuseIdentifier: K.cartTableCell)
        totalPriceLabel.text = String(calTotal())
    }
    

    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func purchaseButtontapped(_ sender: UIButton) {
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


