//
//  OrderTableViewCell.swift
//  CafeNIBMCustomer
//
//  Created by Imalka Muthukumara on 2021-04-13.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var orderID: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupUI(order:Order){
        orderID.text = order.orderID
        status.text = order.orderStatus
        totalPrice.text = String(order.orderTotal)
    }
}
