//
//  AddViewController.swift
//  0712_MyVending
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class AddViewController2: UIViewController {
    
    @IBOutlet var addFoodBtn: [UIButton]!
    @IBOutlet var addMoneyBtn: [UIButton]!
    @IBOutlet var purchaseBtn: [UIButton]!
    
    @IBOutlet var capacityLabel: [UILabel]!
    @IBOutlet var foodImageView: [UIImageView]!
    @IBOutlet weak var moneyLabel: UILabel!
    
    let center = NotificationCenter.default
    let nc = Notification.Name("NotificationIdentifier2")
    var vendingMachine2 = FoodVendingMachine2.instance
    
    var purchaseImageXPoint = 40
    var purchaseImageFoodName:String? = nil
    var purchaseImageFoodMenu:Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
        for btn in addMoneyBtn {
            btn.addTarget(self, action: #selector(pressAddMoney(_:)), for: .touchUpInside)
        }
        
        for btn in purchaseBtn {
            btn.addTarget(self, action: #selector(pressPurchase(_:)), for: .touchUpInside)
        }
        
        for btn in addFoodBtn {
            btn.addTarget(self, action: #selector(btnPressed(_:)), for: .touchUpInside)
        }
        
        center.addObserver(self,
                           selector: #selector(catchNotification),
                           name: nc,
                           object: nil)
    }
    
    func initView() {
        let menuList = vendingMachine2.getAllCapcityList()
        for label in capacityLabel {
            if let capacity = menuList[label.tag] {
                label.text = String(capacity) + "개"
            }else {
                label.text = "0개"
            }
        }
        
        moneyLabel.text = "잔액 : " + String(vendingMachine2.balance) + "원"
        for (menu, _) in vendingMachine2.getBuyList() {
            print(menu)
            purchaseImageFoodMenu = menu
            viewPurchasedList()
        }
        
        for imageview in foodImageView {
            imageview.layer.cornerRadius = 10
            imageview.clipsToBounds = true
            imageview.layer.masksToBounds = true
            imageview.layer.borderWidth = 5
            imageview.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //이 코드에서는 굳이 필요없지 않나? ( 질문하기! )
    override func viewWillAppear(_ animated: Bool) {
        //        if let imageview = makeImageView(x: purchaseImageXPoint, y: 575) {
        //            self.view.addSubview(imageview)
        //            purchaseImageXPoint += 50
        //            purchaseImageFoodName = nil
        //        }
    }
    
    func viewPurchasedList() {
        if let imageview = makeImageView(x: purchaseImageXPoint, y: 575) {
            self.view.addSubview(imageview)
            purchaseImageXPoint += 50
            purchaseImageFoodMenu = nil
        }
    }
    
    func makeImageView(x: Int, y: Int) -> UIView? {
        if let menu = purchaseImageFoodMenu {
            var cardImage : UIImageView
            
            switch menu {
            case 1: cardImage = UIImageView(image: #imageLiteral(resourceName: "chiken"))
            case 2: cardImage = UIImageView(image: #imageLiteral(resourceName: "pizza"))
            case 3: cardImage = UIImageView(image: #imageLiteral(resourceName: "bossam"))
            case 4: cardImage = UIImageView(image: #imageLiteral(resourceName: "hambuger"))
            case 5: cardImage = UIImageView(image: #imageLiteral(resourceName: "dduck"))
            default: return nil
            }
            cardImage.frame = CGRect(x: x, y: y, width: 140, height: 100)
            
            return cardImage
        }else {
            return nil
        }
    }
    
    func btnPressed(_ btn: UIButton) {
        
        var food: Food
        switch btn.tag {
        case 1:
            food = Chicken(restaurant: "굽네치킨", capacity: 5, price: 10000, name: "고추바사삭", manufacturingDate: Date(),bone: true)
        case 2:
            food = Pizza(restaurant: "피자헛", capacity: 20, price: 12000, name: "피자", manufacturingDate: Date(), cheeseCrust: true)
        case 3:
            food = Bossam(restaurant: "원할머니보쌈", capacity: 30, price: 13000, name: "보쌈정식", manufacturingDate: Date(), noodle: true)
        case 4:
            food = Hambuger(restaurant: "맥도날드", capacity: 40, price: 14000, name: "빅맥버거", manufacturingDate: Date())
        case 5:
            food = Dduckppokki(restaurant: "엽기떡볶이", capacity: 50, price: 15000, name: "엽떡", manufacturingDate: Date(), spicy: .high)
            
        default:
            food = Food()
        }
        
        vendingMachine2.add(food: food)
    }
    
    func pressPurchase(_ btn: UIButton) {
        print(String(btn.tag)+"눌림")
        let menu = btn.tag
        
        let balance = vendingMachine2.buy(menu: menu)
        if balance > 0 {
            moneyLabel.text = "잔액 : " + String(balance)
            purchaseImageFoodMenu = menu
            viewPurchasedList()
        }else if balance == -2 {
            moneyLabel.text = "선택제품의 재고가 부족합니다."
        }else if balance == -1 {
            moneyLabel.text = "잔액이 부족합니다."
        }else {
            print("type error")
        }
    }
    
    func pressAddMoney(_ btn: UIButton) {
        
        var balance: Int = 0
        switch btn.tag {
        case 1000: balance = vendingMachine2.add(money: 1000)
        case 5000: balance = vendingMachine2.add(money: 5000)
        default:
            print("error!!!!!!")
        }
        
        moneyLabel.text = "잔액 : " + String(balance) + "원"
        print("돈 추가 : " + String(vendingMachine2.balance))
    }
    
    func catchNotification(notification:Notification) -> Void {
        print("Catch notification")
        
        if let foodList = notification.object as? [Int : Int] ?? nil {
            for (menu, capacity) in foodList {
                capacityLabel[menu-1].text = String(capacity)+"개"
            }
        }
    }
}
