//
//  CustomCameraView.swift
//  measure
//
//  Created by Edward Focer on 14/05/25.
//

import SwiftUI

struct CustomCameraView: View {
    @Environment(\.dismiss) var dismiss

    @StateObject private var cameraService = CameraService()

    var body: some View {
        ZStack {
            if let image = cameraService.photo {
                VStack {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()

                    HStack {
                        Button("Retake") {
                            cameraService.photo = nil
                            DispatchQueue.global(qos: .userInitiated).async {
                                cameraService.startSession()
                            }
                        }
                        .padding()
                        .foregroundColor(.white)

                        Spacer()

                        Button("Use Photo") {
                            dismiss()
                        }
                        .padding()
                        .foregroundColor(.white)
                    }
                    .background(Color.black)
                }
            } else {
                ZStack {
                    CameraPreview(service: cameraService)
                        .ignoresSafeArea()

                    VStack {
                        Text("Capture the first image of the pool for this project by containing the entire pool within the blue bars, touching both sides of the white square")
                            .font(.body)
                            .foregroundColor(.white)
                            .padding()
                            .multilineTextAlignment(.center)

                        Spacer()

                        GeometryReader { geo in
                            Rectangle()
                                .strokeBorder(style: StrokeStyle(lineWidth: 2))
                                .foregroundColor(.white)
                                .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.3)
                                .position(x: geo.size.width / 2, y: geo.size.height / 2)
                        }
                        .allowsHitTesting(false)

                        Spacer()

                        HStack {
                            Button("Cancel") {
                                cameraService.stopSession()
                                dismiss()
                            }
                            .foregroundColor(.white)
                            .padding(.leading, 24)

                            Spacer()

                            VStack(spacing: 8) {
                                Text("PHOTO")
                                    .font(.caption)
                                    .foregroundColor(.yellow)

                                Button(action: {
                                    cameraService.capturePhoto()
                                }) {
                                    ZStack {
                                        Circle()
                                            .stroke(lineWidth: 4)
                                            .frame(width: 70, height: 70)
                                            .foregroundColor(.white)
                                        Circle()
                                            .frame(width: 60, height: 60)
                                            .foregroundColor(.white)
                                    }
                                }
                            }

                            Spacer()

                            Button(action: {
                                cameraService.switchCamera()
                            }) {
                                Image(systemName: "camera.rotate")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                            }
                            .padding(.trailing, 24)
                        }
                        .padding(.bottom, 30)
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            DispatchQueue.global(qos: .userInitiated).async {
                cameraService.startSession()
            }
        }
        .onDisappear {
            cameraService.stopSession()
        }
    }
}
