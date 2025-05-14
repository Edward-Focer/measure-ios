//
//  Project.swift
//  measure
//
//  Created by Edward Focer on 14/05/25.
//

import Foundation

struct Project: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let imageName: String
}
