//
//  CreateNewProjectView.swift
//  measure
//
//  Created by Edward Focer on 14/05/25.
//

import SwiftUI

struct CreateNewProjectView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: CreateProjectViewModel
    var dismissSheet: (() -> Void)? = nil
    @State private var goToNext = false
    
    var body: some View {
            ZStack(alignment: .topTrailing) {
                // Background
                Color(red: 230/255, green: 234/255, blue: 239/255) // Deep Sea 50
                    .ignoresSafeArea()
                
                // Scrollable Form Content
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Spacer().frame(height: 32)
                        
                        // Title
                        Text("Create new project")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(red: 0/255, green: 46/255, blue: 94/255)) // Deep Sea 500
                        
                        Text("Fill out the detailed information below")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(Color(red: 84/255, green: 115/255, blue: 147/255)) // Deep Sea 300
                        
                        // Project Name
                        Group {
                            Text("Give this project a name")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color(red: 0/255, green: 46/255, blue: 94/255))
                            
                            CustomTextField(placeholder: "Name", text: $viewModel.name)
                        }
                        
                        // Homeowner Details
                        Text("Homeowner Details")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color(red: 0/255, green: 46/255, blue: 94/255))
                            .padding(.top)
                        
                        Group {
                            Text("Primary contact name")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color(red: 0/255, green: 46/255, blue: 94/255))
                            
                            CustomTextField(placeholder: "Name", text: $viewModel.contactName)
                            
                            Text("Email")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color(red: 0/255, green: 46/255, blue: 94/255))
                            
                            CustomTextField(placeholder: "Email", text: $viewModel.email, keyboardType: .emailAddress)
                            
                            Text("Phone number")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color(red: 0/255, green: 46/255, blue: 94/255))
                            
                            CustomTextField(placeholder: "+1 xxx xxx xxx", text: $viewModel.phoneNumber, keyboardType: .phonePad)
                        }
                        
                        // Next Button
                        NavigationLink(
                            destination: AdditionalInfoView(dismissSheet: dismissSheet)
                                .environmentObject(viewModel),
                            isActive: $goToNext
                        ) {
                            EmptyView()
                        }
                        
                        Button(action: {
                            goToNext = true
                            viewModel.address = Address(line1: "", line2: "", city: "", state: "", zipcode: "")
                        }) {
                            Text("Next")
                                .font(.system(size: 17, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color(red: 0/255, green: 46/255, blue: 94/255))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding(.top, 20)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 14)
                }
                
                // Custom Circular X Button
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(Color.gray)
                        .frame(width: 24, height: 24)
                        .padding(4)
                        .background(
                            Circle()
                                .fill(Color(red: 203/255, green: 208/255, blue: 213/255)) // approx. #CBD0D5
                        )
                }
                .padding(.trailing, 20)
                .padding(.top, 10)
            }
    }
}
