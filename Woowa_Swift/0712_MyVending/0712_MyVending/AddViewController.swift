//
//  AddViewController.swift
//  0712_MyVending
//
//  Created by woowabrothers on 2017. 7. 12..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet var addFoodBtn: [UIButton]!
    @IBOutlet var addMoneyBtn: [UIButton]!
    @IBOutlet var purchaseBtn: [UIButton]!
    
    @IBOutlet var capacityLabel: [UILabel]!
    @IBOutlet var foodImageView: [UIImageView]!
    @IBOutlet weak var moneyLabel: UILabel!
    
    let center = NotificationCenter.default
    let nc = Notification.Name("NotificationIdentifier")
    var vendingMachine = FoodVendingMachine.instance
    
    var chickenName = "굽네치킨-고추바사삭"
    let pizzaName = "피자헛-피자"
    let bossamName = "원할머니보쌈-보쌈정식"
    let hambugerName = "맥도날드-빅맥버거"
    let dduckppokkiName = "엽기떡볶이-엽떡"
    
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
        for label in capacityLabel {
            label.text = "0개"
        }
        
        moneyLabel.text = "잔액 : " + String(vendingMachine.balance) + "원"
        
        for (foodName, _) in vendingMachine.getBuyList() {
            print(foodName)
            purchaseImageFoodName = foodName
//            viewWillAppear(true)
<<<<<<< HEAD
=======
            viewPurchasedList()
>>>>>>> f7f32b2e6091a19b0ab2de030e03f6ad13194711
        }
        
        for (foodName, capacity) in vendingMachine.getMenuList() {
            switch foodName {
            case chickenName: capacityLabel[0].text = String(capacity)+"개"
            case pizzaName: capacityLabel[1].text = String(capacity)+"개"
            case bossamName: capacityLabel[2].text = String(capacity)+"개"
            case hambugerName: capacityLabel[3].text = String(capacity)+"개"
            case dduckppokkiName: capacityLabel[4].text = String(capacity)+"개"
            default:
                print("error!!!!!!")
            }
        }
<<<<<<< HEAD

        for imageview in foodImageView {
            imageview.layer.cornerRadius = 10
            imageview.clipsToBounds = true
            imageview.layer.masksToBounds = true
            imageview.layer.borderWidth = 5
            imageview.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    func test() {
        if let imageview = makeImageView(x: purchaseImageXPoint, y: 575) {
            self.view.addSubview(imageview)
            purchaseImageXPoint += 50
            purchaseImageFoodName = nil
        }
    }
    
    //호출을 appdelegate에서 했더니 안된다.
    override func viewWillDisappear(_ animated: Bool) {
        let data = NSKeyedArchiver.archivedData(withRootObject: vendingMachine)
        UserDefaults.standard.set(data, forKey: "vendingMachine")
        
        print("bye, saved : " + String(vendingMachine.balance))
        print(purchaseImageXPoint)
=======
>>>>>>> f7f32b2e6091a19b0ab2de030e03f6ad13194711
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
<<<<<<< HEAD
//
//        super.viewWillAppear(animated)
//        test()
        print(#function)
    }

    override var shouldAutomaticallyForwardAppearanceMethods: Bool {
        return false
=======
    }
    
    func viewPurchasedList() {
        if let imageview = makeImageView(x: purchaseImageXPoint, y: 575) {
            self.view.addSubview(imageview)
            purchaseImageXPoint += 50
            purchaseImageFoodName = nil
        }
>>>>>>> f7f32b2e6091a19b0ab2de030e03f6ad13194711
    }
    
    func makeImageView(x: Int, y: Int) -> UIView? {
        if let foodName = purchaseImageFoodName {
            var cardImage : UIImageView
            
            switch foodName {
                case chickenName: cardImage = UIImageView(image: #imageLiteral(resourceName: "chiken"))
                case pizzaName: cardImage = UIImageView(image: #imageLiteral(resourceName: "pizza"))
                case bossamName: cardImage = UIImageView(image: #imageLiteral(resourceName: "bossam"))
                case hambugerName: cardImage = UIImageView(image: #imageLiteral(resourceName: "hambuger"))
                case dduckppokkiName: cardImage = UIImageView(image: #imageLiteral(resourceName: "dduck"))
            default: return nil
            }
            cardImage.frame = CGRect(x: x, y: y, width: 140, height: 100)
            
            return cardImage
        }else {
            return nil
        }
    }
    
    @objc public func locationUpdated(notification:Notification) {
        //Do something
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
        
        vendingMachine.add(food: food)
    }
    
    func pressPurchase(_ btn: UIButton) {
        print(String(btn.tag)+"눌림")
        var foodName: String
        switch btn.tag {
        case 1: foodName = chickenName
        case 2: foodName = pizzaName
        case 3: foodName = bossamName
        case 4: foodName = hambugerName
        case 5: foodName = dduckppokkiName
            
        default:
            return
        }
        
        let balance = vendingMachine.buy(foodName: foodName)
        if balance > 0 {
            moneyLabel.text = "잔액 : " + String(balance)
            purchaseImageFoodName = foodName
<<<<<<< HEAD
            if let imageview = makeImageView(x: purchaseImageXPoint, y: 575) {
                self.view.addSubview(imageview)
                purchaseImageXPoint += 50
                purchaseImageFoodName = nil
            }
//            viewWillAppear(true)
=======
//            viewWillAppear(true)
            viewPurchasedList()
>>>>>>> f7f32b2e6091a19b0ab2de030e03f6ad13194711
        }else if balance == -2 {
            moneyLabel.text = foodName + " 재고부족"
        }else {
            moneyLabel.text = "잔액이 부족합니다."
        }
    }
    
    func pressAddMoney(_ btn: UIButton) {
        var balance: Int = 0
        switch btn.tag {
        case 1000: balance = vendingMachine.add(money: 1000)
        case 5000: balance = vendingMachine.add(money: 5000)
        default:
            print("error!!!!!!")
        }
        
        moneyLabel.text = "잔액 : " + String(balance) + "원"
        print("돈 추가 : " + String(vendingMachine.balance))
    }
    
    func catchNotification(notification:Notification) -> Void {
        print("Catch notification")
        
        if let foodList = notification.object as? [String : Int] ?? nil {
            for (foodName, capacity) in foodList {
                switch foodName {
                case chickenName: capacityLabel[0].text = String(capacity)+"개"
                case pizzaName: capacityLabel[1].text = String(capacity)+"개"
                case bossamName: capacityLabel[2].text = String(capacity)+"개"
                case hambugerName: capacityLabel[3].text = String(capacity)+"개"
                case dduckppokkiName: capacityLabel[4].text = String(capacity)+"개"
                default:
                    print("error!!!!!!")
                }
            }
        }
    }
}
