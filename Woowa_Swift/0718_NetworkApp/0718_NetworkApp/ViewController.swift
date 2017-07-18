//
//  ViewController.swift
//  0718_NetworkApp
//
//  Created by woowabrothers on 2017. 7. 18..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var jumpBtn = UIButton()
    var getBtn = UIButton()
    var postBtn = UIButton()
    var imageview = UIImageView()
    var editText = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewinit()
        
        jumpBtn.addTarget(self, action: #selector(pressJump(_:)), for: .touchUpInside)
        getBtn.addTarget(self, action: #selector(pressGet(_:)), for: .touchUpInside)
        postBtn.addTarget(self, action: #selector(pressPost(_:)), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(catchCallNoti), name: NSNotification.Name("GET"), object: DataTask.self)
        NotificationCenter.default.addObserver(self, selector: #selector(catchPostNoti), name: NSNotification.Name("POST"), object: DataTask.self)
    }
    
    func viewinit() {
        jumpBtn = UIButton(frame: CGRect(x: 150, y: 50, width: 200, height: 60))
        jumpBtn.backgroundColor = UIColor(red: 255/255, green: 250/255, blue: 134/255, alpha: 1)
        jumpBtn.setTitle("JUMP", for: .normal)
        jumpBtn.setTitleColor(UIColor(red: 99/255, green: 116/255, blue: 226/255, alpha: 1), for: .normal)
        jumpBtn.center.x = view.center.x
        self.view.addSubview(jumpBtn)
        
        imageview = UIImageView(frame: CGRect(x: 100, y: 200, width: 400, height: 250))
        imageview.image = #imageLiteral(resourceName: "hambuger.png")
        imageview.center.x = view.center.x
        self.view.addSubview(imageview)
        
        getBtn = UIButton(frame: CGRect(x: 100, y: 500, width: 100, height: 60))
        getBtn.backgroundColor = UIColor(red: 159/255, green: 162/255, blue: 161/255, alpha: 1)
        getBtn.setTitle("GET", for: .normal)
        getBtn.titleLabel?.textColor = UIColor.white
        getBtn.center.x = view.center.x - view.center.x/2
        self.view.addSubview(getBtn)
        
        postBtn = UIButton(frame: CGRect(x: 300, y: 500, width: 100, height: 60))
        postBtn.backgroundColor = UIColor(red: 135/255, green: 185/255, blue: 253/255, alpha: 1)
        postBtn.setTitle("POST", for: .normal)
        postBtn.titleLabel?.textColor = UIColor.white
        postBtn.center.x = view.center.x + view.center.x/2
        self.view.addSubview(postBtn)
        
        editText = UITextField(frame: CGRect(x: 300, y: 580, width: 150, height: 40))
        editText.center.x = view.center.x + view.center.x/2
        editText.layer.borderColor = UIColor.black.cgColor
        editText.layer.borderWidth = 2
        self.view.addSubview(editText)
    }
    
    func pressJump(_ btn: UIButton) {
        UIView.animate(withDuration: 5, animations: {
            self.imageview.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        },completion: { (complete:Bool) in
            UIView.animate(withDuration: 5, animations: {
                self.imageview.frame = CGRect(x: 100, y: 200, width: 400, height: 250)
                self.imageview.center.x = self.view.center.x
            })
        })
    }
    
    func pressGet(_ btn: UIButton) {
        print("pressGET")
        DataTask().getCall()
    }
    
    func pressPost(_ btn: UIButton) {
        print("pressPOST")
        if let input = editText.text {
            DataTask().getPost(input: input)
            editText.text?.removeAll()
        }else {
             DataTask().getPost(input: "안됐으뮤ㅠ")
        }
    }
    
    func catchCallNoti(_ notification: Notification) {
        print(notification.userInfo?["result"] ?? "ddd")
    }
    
    func catchPostNoti(_ notification: Notification) {
        print(notification.userInfo?["result"] ?? "fail")
    }
}
