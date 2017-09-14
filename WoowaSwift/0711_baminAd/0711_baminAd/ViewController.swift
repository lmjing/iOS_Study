//
//  ViewController.swift
//  0711_baminAd
//
//  Created by woowabrothers on 2017. 7. 11..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonTouched(_ sender: Any) {
        // check highlight와 동일
        // 이전 상태에서 반대로
        self.imageView.isHighlighted = !self.imageView.isHighlighted
    }

}

