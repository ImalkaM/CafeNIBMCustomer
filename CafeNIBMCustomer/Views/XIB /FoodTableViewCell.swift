//
//  FoodTableViewCell.swift
//  CafeNIBMCustomer
//
//  Created by Imalka Muthukumara on 2021-04-11.
//

import UIKit
import Kingfisher

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodDescription: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var discountlabel: UILabel!
    @IBOutlet weak var discountContainer: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    
    func setupView(foodItem:FoodItem){
        foodName.text = foodItem.foodName
        foodDescription.text = foodItem.foodDescription
        foodPrice.text = "RS.\(String(foodItem.foodPrice))"
        foodImage.kf.setImage(with: URL(string: foodItem.image))
        
        if foodItem.discount > 0 {
            discountContainer.isHidden = false
            discountlabel.text =  "\(String(foodItem.discount))%"
        }else{
            discountContainer.isHidden = true
            discountlabel.text = ""
        }
    }
}
