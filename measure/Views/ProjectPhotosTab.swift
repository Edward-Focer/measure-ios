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
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(project.imageLocalPath ?? [], id: \.self) { path in
                        if let image = Utility.shared.loadImageFromDocuments(path: path) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .cornerRadius(8)
                        }
                    }
                }
            }
            .padding()
            
            Spacer()
            
            // Add Photo
            Button(action: {
                showImagePicker.toggle()
            }) {
                Text("Add photo")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 0/255, green: 46/255, blue: 94/255)) // Deep Sea Blue
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .font(.system(size: 17, weight: .semibold))
            }
            .padding()

        }
        .navigationTitle(project.notes)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showImagePicker) {
            GalleryImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage)
        }
    }
}
