//
//  OrderViewController.swift
//  CafeNIBMCustomer
//
//  Created by Imalka Muthukumara on 2021-04-13.
//

import UIKit
import Firebase

class OrderViewController: UIViewController {
    var ref: DatabaseReference!
    
    var orders:[Order] = []
    var sessionMGR = SessionManager()
    
    @IBOutlet weak var orderTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        orderTable.register(UINib(nibName: K.nibNameOrderTable, bundle: nil), forCellReuseIdentifier: K.orderTableCell)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getOrders()
    }
    
}

extension OrderViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.orderTableCell, for: indexPath) as! OrderTableViewCell
        
        cell.setupUI(order: orders[indexPath.row])
        
        return cell
    }
    
}

extension OrderViewController{
    
    func getOrders(){
        
        self.orders.removeAll()
        
        
        self.ref.child("orders").child(sessionMGR.getUserData().email
                                        .replacingOccurrences(of: "@", with: "_")
                                        .replacingOccurrences(of: ".", with: "_"))
            .observe(.value) { (snapshot) in
                if let data = snapshot.value{
                    if let orders = data as? [String:Any]{
                        for singleOrder in orders{
                            if let orderInfo = singleOrder.value as? [String:Any]{
                                var placedOrder = Order()
                                placedOrder.orderID = singleOrder.key
                                placedOrder.orderStatus = orderInfo["status"] as! String
                                if let orderItems = orderInfo["orderItems"] as? [Any]{
                                    for item in orderItems{
                                       if let itemInfo = item as? [String:Any]{
                                        placedOrder.orderTotal += itemInfo["foodPrice"] as! Double
                                        }
                                    }
                                }
                                self.orders.append(placedOrder)
                            }
                            self.orderTable.reloadData()
                        }
                    }
                }
            }

    }
}
