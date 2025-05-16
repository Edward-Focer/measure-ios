//
//  Scan.swift
//  measure
//
//  Created by Edward Focer on 16/05/25.
//

import Foundation

struct Scan: Identifiable {
    let id = UUID()
    let date: String
    let scanner: String
    let uploaded: Bool
}
