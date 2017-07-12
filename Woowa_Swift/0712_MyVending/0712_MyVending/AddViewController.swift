//
//  AddViewController.swift
//  0712_MyVending
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var chickenBtn: UIButton!
    @IBOutlet weak var pizzaBtn: UIButton!
    @IBOutlet weak var bossamBtn: UIButton!
    @IBOutlet weak var hambugerBtn: UIButton!
    @IBOutlet weak var dduckBtn: UIButton!
    
    @IBOutlet weak var chickenLabel: UILabel!
    @IBOutlet weak var pizzaLabel: UILabel!
    @IBOutlet weak var bossamLabel: UILabel!
    @IBOutlet weak var hambugerLabel: UILabel!
    @IBOutlet weak var dduckLabel: UILabel!
    
    let center = NotificationCenter.default
    let nc = Notification.Name("NotificationIdentifier")
    let vendingMachine = FoodVendingMachine()
    
    let chicken = Chicken(restaurant: "굽네치킨", capacity: 5, price: 10000, name: "고추바사삭", manufacturingDate: Date(),bone: true)
    let pizza = Pizza(restaurant: "피자헛", capacity: 20, price: 12000, name: "피자", manufacturingDate: Date(), cheeseCrust: true)
    let bossam = Bossam(restaurant: "원할머니보쌈", capacity: 30, price: 13000, name: "보쌈정식", manufacturingDate: Date(), noodle: true)
    let hambuger = Hambuger(restaurant: "맥도날드", capacity: 40, price: 14000, name: "빅맥버거", manufacturingDate: Date())
    let dduckppokki = Dduckppokki(restaurant: "엽기떡볶이", capacity: 50, price: 15000, name: "엽떡", manufacturingDate: Date(), spicy: .high)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chickenLabel.text = "재고 : " + String(chicken.capacity)
        pizzaLabel.text = "재고 : " + String(pizza.capacity)
        bossamLabel.text = "재고 : " + String(bossam.capacity)
        hambugerLabel.text = "재고 : " + String(hambuger.capacity)
        dduckLabel.text = "재고 : " + String(dduckppokki.capacity)
        
        chickenBtn.addTarget(self, action: #selector(btnPressed(_:)), for: .touchUpInside)
        pizzaBtn.addTarget(self, action: #selector(btnPressed(_:)), for: .touchUpInside)
        bossamBtn.addTarget(self, action: #selector(btnPressed(_:)), for: .touchUpInside)
        hambugerBtn.addTarget(self, action: #selector(btnPressed(_:)), for: .touchUpInside)
        dduckBtn.addTarget(self, action: #selector(btnPressed(_:)), for: .touchUpInside)
    
        center.addObserver(self,
                       selector: #selector(catchNotification),
                       name: nc,
                       object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc public func locationUpdated(notification:Notification) {
        //Do something
    }
    
    func btnPressed(_ btn: UIButton) {
       
        var food: Food
        switch btn.tag {
        case 1:
            food = chicken
        case 2:
            food = pizza
        case 3:
            food = bossam
        case 4:
            food = hambuger
        case 5:
            food = dduckppokki
            
        default:
            food = Food()
        }
        
        vendingMachine.add(food: food)
    }
    
    func catchNotification(notification:Notification) -> Void {
        print("Catch notification")
        
        if let foodList = notification.object as? [String : Int] ?? nil {
            for (foodName, capacity) in foodList {
                switch foodName {
                case chicken.restaurant + "-" + chicken.name: chickenLabel.text = "재고 : " + String(capacity)
                case pizza.restaurant + "-" + pizza.name: pizzaLabel.text = "재고 : " + String(capacity)
                case bossam.restaurant + "-" + bossam.name: bossamLabel.text = "재고 : " + String(capacity)
                case hambuger.restaurant + "-" + hambuger.name: hambugerLabel.text = "재고 : " + String(capacity)
                case dduckppokki.restaurant + "-" + dduckppokki.name: dduckLabel.text = "재고 : " + String(capacity)
                default:
                    print("error!!!!!!")
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
