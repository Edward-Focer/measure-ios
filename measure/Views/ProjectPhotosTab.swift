//
//  ProjectPhotosTab.swift
//  measure
//
//  Created by Edward Focer on 16/05/25.
//

import SwiftUI

struct ProjectPhotosTab: View {
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage? = nil
    let project: Project

    // Define grid layout
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(project.imageLocalPath ?? [], id: \.self) { path in
                        if let image = Utility.shared.loadImageFromDocuments(path: path) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .clipped()
                                .cornerRadius(8)
                        } else {
                            Image(path) // default asset image fallback
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .clipped()
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }

            Spacer()

            // Add Photo Button
            Button(action: {
                showImagePicker.toggle()
            }) {
                Text("Add photo")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color(red: 0/255, green: 46/255, blue: 94/255)) // Deep Sea Blue
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .font(.system(size: 17, weight: .semibold))
            }
            .padding(.horizontal)
            .padding(.bottom, 16)
        }
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showImagePicker, onDismiss: {
            if let image = selectedImage {
                if let savedPath = Utility.shared.saveImageToDocuments(image: image, fileName: "photo_\(UUID().uuidString).jpg") {
                    if var paths = project.imageLocalPath {
                        paths.append(savedPath.lastPathComponent)
                        print("✅ Image saved and path appended:", savedPath.lastPathComponent)
                    }
                }
            }
        }) {
            GalleryImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage)
        }
    }
}
