//
//  CartTableViewCell.swift
//  CafeNIBMCustomer
//
//  Created by Imalka Muthukumara on 2021-04-11.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var qtyLabel: UILabel!
    
    var delegate: CartItemDelegate!
    var indexPath: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func plusButtonTapped(_ sender: UIButton) {
        delegate.plusButtonTapped(at: indexPath)
    }
    
    
    @IBAction func minusButtontapped(_ sender: UIButton) {
        
        delegate.minusButtontapped(at: indexPath)
    }

}

protocol CartItemDelegate {
    func plusButtonTapped(at indexPath: IndexPath)
    func minusButtontapped(at indexPath: IndexPath)
}
