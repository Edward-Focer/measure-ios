//
//  CreateProjectViewModel.swift
//  measure
//
//  Created by Edward Focer on 16/05/25.
//

import Foundation
import SwiftUI
import Combine

class CreateProjectViewModel: ObservableObject {
    
    @Published var activeProjects: [Project] = [
        Project(
            name: "Garry Taylor",
            contactName: "Garry Taylor",
            email: "garry@example.com",
            phoneNumber: "+1 123-456-7890",
            date: "08.29.2023 at 11:25 AM",
            imageLocalPath: ["pool_1"],
            notes: "Test pool",
            address: Address(line1: "123 Main St", line2: "Apt 4B", city: "New York", state: "NY", zipcode: "10001"),
            scans: []
        ),
        Project(
            name: "Jane Doe",
            contactName: "Jane Doe",
            email: "jane@example.com",
            phoneNumber: "+1 987-654-3210",
            date: "09.01.2023 at 09:00 AM",
            imageLocalPath: ["pool_2"],
            notes: "Test pool",
            address: Address(line1: "123 Main St", line2: "Apt 4B", city: "New York", state: "NY", zipcode: "10001"),
            scans: []
        ),
        Project(
            name: "John Smith",
            contactName: "John Smith",
            email: "john@example.com",
            phoneNumber: "+1 555-555-5555",
            date: "09.15.2023 at 05:30 PM",
            imageLocalPath: ["pool_3"],
            notes: "Test pool",
            address: Address(line1: "123 Main St", line2: "Apt 4B", city: "New York", state: "NY", zipcode: "10001"),
            scans: []
        )
    ]
    @Published var uploadedProjects: [Project] = []
    
    // Project basic info
    @Published var name: String = ""
    @Published var contactName: String = ""
    @Published var email: String = ""
    @Published var phoneNumber: String = ""
    
    // Address details
    @Published var address: Address = Address(line1: "", line2: "", city: "", state: "", zipcode: "")
    
    // Project notes
    @Published var notes: String = ""
    
    // Selected project image
    @Published var selectedImageUrl: [String] = []
    
    // Date of project creation - you can generate it on submission or initialize here
    @Published var date: String = ""
    
    // Scans
    @Published var scans: [Scan] = []
    
    // Reset all form fields to initial empty states
    func reset() {
        name = ""
        contactName = ""
        email = ""
        phoneNumber = ""
        address = Address(line1: "", line2: "", city: "", state: "", zipcode: "")
        notes = ""
        selectedImageUrl = []
        date = ""
        scans = []
    }
    
    // Create a Project instance from current data
    func buildProject() -> Project {
        return Project(
            name: name,
            contactName: contactName,
            email: email,
            phoneNumber: phoneNumber,
            date: date.isEmpty ? Self.currentDateString() : date,
            imageLocalPath: selectedImageUrl, // If image is local, you may store image path or id, or handle differently
            notes: notes,
            address: Address(line1: address.line1, line2: address.line2, city: address.city, state: address.state, zipcode: address.zipcode),
            scans: scans
        )
    }
    
    // Add project to the list (simulate save)
    func saveProject() {
        let newProject = buildProject()
        uploadedProjects.append(newProject)
    }
    
    // Helper to generate formatted date string
    static func currentDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy 'at' hh:mm a"
        return formatter.string(from: Date())
    }
}
