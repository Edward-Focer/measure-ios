//
//  ProjectDetailsTab.swift
//  measure
//
//  Created by Edward Focer on 16/05/25.
//

import SwiftUI

struct ProjectDetailsTab: View {
    let project: Project
    
    var body: some View {
        VStack {
            // Project Image
            if let imagePath = project.imageLocalPath?.first,
               let image = Utility.shared.loadImageFromDocuments(path: imagePath) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(10, corners: [.topLeft, .topRight])
            } else {
                // Placeholder Image in case image is missing or unavailable
                Image(project.imageLocalPath?.first ?? "pool_2") // Replace with an actual placeholder image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(10, corners: [.topLeft, .topRight])
            }
            
            // Project Information
            VStack {
                HStack {
                    Text(project.name)
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.top, 4)
                    Spacer()
                }
                HStack {
                    Text("Scan Completed on \(project.date)")
                        .font(.subheadline)
                        .foregroundColor(Color(red: 84/255, green: 115/255, blue: 147/255))
                    Spacer()
                }
                .padding(.bottom, 4)
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Address")
                            .font(.body)
                            .foregroundColor(Color(red: 84/255, green: 115/255, blue: 147/255))
                        Spacer()
                        Text("\(project.address.line1), \(project.address.city), \(project.address.state), \(project.address.zipcode)")
                            .font(.body)
                    }
                    HStack {
                        Text("Primary Contact")
                            .font(.body)
                            .foregroundColor(Color(red: 84/255, green: 115/255, blue: 147/255))
                        Spacer()
                        Text(project.contactName)
                            .font(.body)
                    }
                    
                    
                    HStack {
                        Text("Phone Number")
                            .font(.body)
                            .foregroundColor(Color(red: 84/255, green: 115/255, blue: 147/255))
                        Spacer()
                        Text(project.phoneNumber)
                            .font(.body)
                    }
                    
                    HStack {
                        Text("Email Address")
                            .font(.body)
                            .foregroundColor(Color(red: 84/255, green: 115/255, blue: 147/255))
                        Spacer()
                        Text(project.email)
                            .font(.body)
                    }
                }
            }
            .padding()
            
            Spacer()
            
            // Action Buttons
            VStack(spacing: 16) {
                // Upload to Portal Button
                Button(action: {
                    // Upload to Portal action
                }) {
                    Text("Upload to Portal")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0/255, green: 46/255, blue: 94/255)) // Deep Sea Blue
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .font(.system(size: 17, weight: .semibold))
                }
                
                // Measure the pool Button
                Button(action: {
                    // Measure Pool action
                }) {
                    Text("Measure the pool")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0/255, green: 46/255, blue: 94/255)) // Deep Sea Blue
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .font(.system(size: 17, weight: .semibold))
                }
            }
            .padding([.leading, .trailing], 16)
            .padding(.top, 10)
        }
        .navigationBarBackButtonHidden(true)
    }
}

// Define a custom button style for primary action buttons
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}

// Define a custom button style for secondary action buttons
struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .foregroundColor(.blue)
            .cornerRadius(8)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.blue))
    }
}
