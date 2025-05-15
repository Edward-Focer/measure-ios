//
//  Address.swift
//  measure
//
//  Created by Edward Focer on 15/05/25.
//

import Foundation

struct Address: Codable {
    var line1: String
    var line2: String
    var city: String
    var state: String
    var zipcode: String
}
