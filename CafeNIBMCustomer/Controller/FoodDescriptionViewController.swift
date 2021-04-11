//
//  FoodDescriptionViewController.swift
//  CafeNIBMCustomer
//
//  Created by Imalka Muthukumara on 2021-04-11.
//

import UIKit
import  Kingfisher

class FoodDescriptionViewController: UIViewController {
    
    
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var offerLabel: UILabel!
    
    @IBOutlet weak var offerView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var foodDescriptionItem:FoodItem = FoodItem(id: "", foodName: "", foodDescription: "", category: "", foodPrice: 0.0, discount: 0, image: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        foodNameLabel.text = foodDescriptionItem.foodName
        priceLabel.text = ("RS.\(String(foodDescriptionItem.foodPrice))")
        foodImage.kf.setImage(with: URL(string: foodDescriptionItem.image))
        descriptionLabel.text = foodDescriptionItem.foodDescription
        
        if foodDescriptionItem.discount > 0 {
            offerView.isHidden = false
            offerLabel.text =  "\(String(foodDescriptionItem.discount))%"
        }else{
            offerView.isHidden = true
            offerLabel.text = ""
        }
    }
    


    @IBAction func backButtonTapped(_ sender: UIButton) {
        
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addtoCartTapped(_ sender: UIButton) {
        
        
    }
    
    func setupFoodDescritionView(foodItem:FoodItem){
        foodDescriptionItem.foodName = foodItem.foodName
       
        foodDescriptionItem.foodDescription = foodItem.foodDescription
        foodDescriptionItem.foodPrice = foodItem.foodPrice
        foodDescriptionItem.image = foodItem.image
        foodDescriptionItem.discount = foodItem.discount
        
        
    }

}
