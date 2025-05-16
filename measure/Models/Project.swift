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
    let imageLocalPath: [String]?
    let notes: String
    let address: Address
    let scans: [Scan]?
    
    // Initialize the Project with all properties
    init(name: String, contactName: String, email: String, phoneNumber: String, date: String, imageLocalPath: [String], notes: String, address: Address, scans: [Scan]) {
        self.name = name
        self.contactName = contactName
        self.email = email
        self.phoneNumber = phoneNumber
        self.date = date
        self.imageLocalPath = imageLocalPath
        self.notes = notes
        self.address = address
        self.scans = scans
    }
}
