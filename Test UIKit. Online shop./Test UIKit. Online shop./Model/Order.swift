//
//  memory.swift
//  Test UIKit. Online shop.
//
//  Created by Anton Rubenchik on 13.06.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import Foundation

class Order {
    static let sharedInstance = Order()
    var sum = 0
}
