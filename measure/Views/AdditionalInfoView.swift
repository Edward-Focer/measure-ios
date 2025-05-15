//
//  AdditionalInfoView.swift
//  measure
//
//  Created by Edward Focer on 14/05/25.
//

import SwiftUI
import Photos
import AVFoundation

struct AdditionalInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    var dismissSheet: (() -> Void)? = nil
    var contactName: String
    @State private var addressLine1 = ""
    @State private var addressLine2 = ""
    @State private var city = ""
    @State private var state = ""
    @State private var zipCode = ""
    @State private var projectNotes = ""
    
    @State private var showCamera = false
    @State private var showGallery = false
    @State private var selectedImage: UIImage? = nil
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showReviewProject = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color(red: 230/255, green: 234/255, blue: 239/255).ignoresSafeArea()
            
            ScrollView {
                HStack {
                    // Back Arrow Only
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color(red: 0/255, green: 46/255, blue: 94/255)) // Deep Sea 500
                            .font(.system(size: 18, weight: .semibold))
                            .padding(.leading, 2)
                        Text("Add additional info")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(red: 0/255, green: 46/255, blue: 94/255))
                    }
                    
                    Spacer()
                    
                    // X Button to dismiss entire sheet
                    Button {
                        dismissSheet?()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color.gray)
                            .frame(width: 24, height: 24)
                            .padding(4)
                            .background(
                                Circle()
                                    .fill(Color(red: 203/255, green: 208/255, blue: 213/255)) // #CBD0D5
                            )
                    }
                }
                .padding(.top, 12)
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    Group {
                        Text("Address")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color(red: 0/255, green: 46/255, blue: 94/255))
                        
                        CustomTextField(placeholder: "Address line 1", text: $addressLine1)
                        CustomTextField(placeholder: "Address line 2", text: $addressLine2)
                        CustomTextField(placeholder: "City", text: $city)
                        
                        HStack(spacing: 12) {
                            CustomTextField(placeholder: "State", text: $state)
                            CustomTextField(placeholder: "Zip Code", text: $zipCode)
                        }
                    }
                    
                    Text("Project notes")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color(red: 0/255, green: 46/255, blue: 94/255))
                    CustomTextField(placeholder: "Address line 1", text: $projectNotes)
                    
                    Text("Project photos")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color(red: 0/255, green: 46/255, blue: 94/255))
                    
                    Text("Take new photos or upload existing")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                    HStack(spacing: 12) {
                        Button("Take photo") {
                            checkCameraPermission { granted in
                                if granted {
                                    showCamera = true
                                } else {
                                    alertMessage = "Camera permission is required to take a photo."
                                    showAlert = true
                                }
                            }
                        }
                        .buttonStyleOutlined()
                        
                        Button("Uploaded exist") {
                            checkGalleryPermission { granted in
                                if granted {
                                    showGallery = true
                                } else {
                                    alertMessage = "Photo library permission is required to upload an image."
                                    showAlert = true
                                }
                            }
                        }
                        .buttonStyleOutlined()
                    }
                    
                    Button("Next") {
                        withAnimation {
                                showReviewProject = true
                            }
                    }
                    .font(.system(size: 17, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color(red: 0/255, green: 46/255, blue: 94/255))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.top, 10)
                }
                .padding(20)
            }
            
            if showReviewProject {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            showReviewProject = false
                        }
                    }
                
                VStack {
                    Spacer()

                    ReviewProjectView(
                        projectNotes: projectNotes,
                        contactName: contactName,
                        selectedImage: selectedImage,
                        dismissSheet: {
                            withAnimation {
                                showReviewProject = false
                                dismissSheet?()
                            }
                        }
                    )
                    .frame(maxWidth: .infinity)
                    .frame(height: (selectedImage != nil) ? (UIScreen.main.bounds.height * 0.75) : (UIScreen.main.bounds.height * 0.50))
                    .background(Color.white)
                    .cornerRadius(16, corners: [.topLeft, .topRight])
                    .shadow(radius: 10)
                    .zIndex(1)
                }
                .ignoresSafeArea(edges: .bottom)
            }
        }
        .fullScreenCover(isPresented: $showCamera) {
            CustomCameraView(selectedImage: $selectedImage)
        }
        .sheet(isPresented: $showGallery) {
            GalleryImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Permission Denied"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Permissions
    
    private func checkCameraPermission(completion: @escaping (Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            completion(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        default:
            completion(false)
        }
    }
    
    private func checkGalleryPermission(completion: @escaping (Bool) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized, .limited:
            completion(true)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { newStatus in
                DispatchQueue.main.async {
                    completion(newStatus == .authorized || newStatus == .limited)
                }
            }
        default:
            completion(false)
        }
    }
}

// MARK: - Reusable Button Style

extension Button {
    func buttonStyleOutlined() -> some View {
        self
            .font(.system(size: 16, weight: .medium))
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.white)
            .foregroundColor(Color(red: 0/255, green: 46/255, blue: 94/255))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(red: 0/255, green: 46/255, blue: 94/255)))
            .cornerRadius(8)
    }
}
