//
//  Project.swift
//  measure
//
//  Created by Edward Focer on 14/05/25.
//

import Foundation

struct Project: Identifiable {
    let id = UUID()
    let name: String
    let contactName: String
    let email: String
    let phoneNumber: String
    let date: String
    let imageLocalPath: String?
    let notes: String
    let address: Address
}
