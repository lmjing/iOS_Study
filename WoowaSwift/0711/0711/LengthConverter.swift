//
//  LengthConverter.swift
//  0711
//
//  Created by woowabrothers on 2017. 7. 11..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation

func lengthConverter(input: Double) -> Measurement<UnitLength> {
    let original = Measurement(value: input, unit: UnitLength.meters)
    
    let converted = original.converted(to: UnitLength.centimeters)
    return converted
}
