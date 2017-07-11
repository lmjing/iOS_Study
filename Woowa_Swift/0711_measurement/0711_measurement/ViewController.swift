//
//  ViewController.swift
//  0711_measurement
//
//  Created by woowabrothers on 2017. 7. 11..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Convert(_ sender: Any) {
        let result = lengthConverter()
        
        label.text = result
    }
    
    func lengthConverter() -> String {
        let input = textBox.text!
        
        var original = Measurement(value: Double(input)!, unit: UnitLength.meters)
        original.convert(to: UnitLength.centimeters)
        
        return String(describing: original)
    }
}

