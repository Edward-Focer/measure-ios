//
//  ProjectCard.swift
//  measure
//
//  Created by Edward Focer on 14/05/25.
//

import SwiftUI

struct ProjectCard: View {
    let project: Project
    
    var body: some View {
        NavigationLink(destination: ProjectDetailsView(project: project)) {
            VStack(alignment: .leading, spacing: 0) {
                // Image Section
                if let path = project.imageLocalPath?.first, let image = Utility.shared.loadImageFromDocuments(path: path) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 160)
                        .clipped()
                        .cornerRadius(10, corners: [.topLeft, .topRight])
                } else {
                    Image(project.imageLocalPath?.first ?? "pool_2")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 160)
                        .clipped()
                        .cornerRadius(10, corners: [.topLeft, .topRight])
                }

                // Footer Section
                VStack(alignment: .leading, spacing: 4) {
                    Text(project.name)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("Scan Completed on \(project.date)")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding()
                .frame(maxWidth: .infinity) // ✅ Make footer stretch to full width
                .background(Color(red: 0/255, green: 46/255, blue: 94/255).opacity(0.7))
                .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
            }
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .shadow(radius: 3)
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(PlainButtonStyle())  // Prevents the default button styling of NavigationLink
    }
}
