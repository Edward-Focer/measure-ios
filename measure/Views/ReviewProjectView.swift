//
//  ReviewProjectView.swift
//  measure
//
//  Created by Edward Focer on 15/05/25.
//

import SwiftUI

struct ReviewProjectView: View {
    var projectNotes: String
    var contactName: String
    var selectedImage: UIImage?
    var dismissSheet: (() -> Void)? = nil

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color(red: 230/255, green: 234/255, blue: 239/255)
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Review project")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(red: 0/255, green: 46/255, blue: 94/255))

                    Text("Project notes")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color(red: 0/255, green: 46/255, blue: 94/255))
                    CustomTextField(placeholder: "Project notes", text: .constant(projectNotes))

                    Text("Primary contact name")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color(red: 0/255, green: 46/255, blue: 94/255))
                    CustomTextField(placeholder: "Full name", text: .constant(contactName))

                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .cornerRadius(10)
                    }

                    Button("Done") {
                        dismissSheet?()
                    }
                    .font(.system(size: 17, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color(red: 0/255, green: 46/255, blue: 94/255))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding(20)
            }

            Button(action: {
                dismissSheet?()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.gray)
                    .frame(width: 24, height: 24)
                    .padding(4)
                    .background(Circle().fill(Color(red: 203/255, green: 208/255, blue: 213/255)))
            }
            .padding(.top, 10)
            .padding(.trailing, 20)
        }
    }
}
