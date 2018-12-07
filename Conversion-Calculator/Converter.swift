//
//  Converter.swift
//  Conversion-Calculator
//
//  Created by TianyuanDeng on 12/07/18.
//  Copyright © 2017 Tianyuan Deng. All rights reserved.

import Foundation

struct Converter {
    let label: String
    let inputUnit: String
    let outputUnit: String
    let convert: (Double)->Double
}
