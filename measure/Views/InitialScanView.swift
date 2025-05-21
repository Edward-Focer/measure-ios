//
//  InitialScanView.swift
//  measure
//
//  Created by Edward Focer on 19/05/25.
//

import SwiftUI

struct InitialScanView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var scanProgress: CGFloat = 0.1 // Initial dummy progress
    @State private var showScanProgress = true
    @State private var scanComplete = false
    @State private var showTutorial = true
    @State private var navigateToPerimeterPoints = false

    var body: some View {
        NavigationView {
            ZStack {
                VideoPreview()
                    .ignoresSafeArea()

                VStack(spacing: 12) {
                    HStack(spacing: 12) {
                        DistanceView()
                        AzimuthElevationView()
                        XYZView()
                    }
                    .padding()
                    .cornerRadius(12)
                    .padding(.horizontal)

                    Spacer()
                }
                VStack {
                    Spacer()

                    ZStack {
                        HStack {
                            // Left vertical indicator
                            RoundedRectangle(cornerRadius: 4)
                                .frame(width: 6, height: 150)
                                .foregroundColor(.white.opacity(0.6))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .frame(width: 6, height: 30)
                                        .foregroundColor(.white)
                                        .offset(y: 30)
                                )
                            
                            Spacer()
                            
                            // Right vertical indicator
                            RoundedRectangle(cornerRadius: 4)
                                .frame(width: 6, height: 150)
                                .foregroundColor(.white.opacity(0.6))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .frame(width: 6, height: 30)
                                        .foregroundColor(.white)
                                        .offset(y: -30)
                                )
                        }
                        .padding(.horizontal, 24)
                        
                        VStack(spacing: 8) {
                            // Target reticle
                            Circle()
                                .stroke(Color.white, lineWidth: 2)
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Path { path in
                                        path.move(to: CGPoint(x: 30, y: 0))
                                        path.addLine(to: CGPoint(x: 30, y: 60))
                                        path.move(to: CGPoint(x: 0, y: 30))
                                        path.addLine(to: CGPoint(x: 60, y: 30))
                                    }
                                        .stroke(Color.white, lineWidth: 1)
                                )
                            
                            Text("Please move the camera\naround the pool")
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .font(.subheadline)
                            
                            Text("<– –>")
                                .foregroundColor(.white)
                                .font(.title2)
                        }
                    }
                    
                    Spacer()
                    
                    // Scanning progress bar
                    if showScanProgress {
                        VStack(spacing: 4) {
                            GeometryReader { geometry in
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.white.opacity(0.4))
                                        .frame(height: 20)
                                    
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.blue)
                                        .frame(width: geometry.size.width * scanProgress, height: 20)
                                        .animation(.easeInOut, value: scanProgress)
                                }
                            }
                            .frame(height: 20)
                            .padding(.horizontal, 32)
                            
                            Text("Scanning...  \(Int(scanProgress * 100))%")
                                .foregroundColor(.white)
                                .font(.footnote)
                        }
                        .padding(.bottom, 32)
                    }
                }
                
                if showTutorial {
                    VStack {
                        Spacer()
                        TutorialPopup(showTutorial: $showTutorial)
                            .transition(.move(edge: .bottom))
                            .zIndex(1)
                    }
                }
                if scanComplete {
                    VStack {
                            Spacer()

                            ScanCompletionPopup {
                                // handle Start Capturing Points
                                scanComplete = false
                                showScanProgress = false
                                navigateToPerimeterPoints = true
                            }
                        }
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut, value: scanComplete)
                }
                
                // Hidden NavigationLink
                NavigationLink(destination: PerimeterPointsView().navigationBarBackButtonHidden(true), isActive: $navigateToPerimeterPoints) {
                    EmptyView()
                }
            }
            .navigationBarTitle("Initial Scan", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(.white)
                },
                trailing: Button(action: {
                    // Handle scan option
                }) {
                    Text("Scan Option")
                        .foregroundColor(.white)
                }
            )
            .onChange(of: showTutorial) {
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                    if scanProgress < 1.0 {
                        scanProgress += 0.02
                    } else {
                        scanProgress = 1.0
                        scanComplete = true
                        timer.invalidate()
                    }
                }
            }
        }
    }
}

struct DistanceView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("0 ft")
                .bold()
            Text("0 (0,5)")
            Text("Distance")
                .font(.caption)
        }
        .frame(maxWidth: .infinity,  minHeight: 120)
        .padding()
        .background(Color.white.opacity(0.6))
        .cornerRadius(10)
    }
}

struct AzimuthElevationView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Az: 0")
                .bold()
            Text("El: 0")
            Text("Az, El")
                .font(.caption)
        }
        .frame(maxWidth: .infinity,  minHeight: 120)
        .padding()
        .background(Color.white.opacity(0.6))
        .cornerRadius(10)
    }
}

struct XYZView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("x: 0")
                .bold()
            Text("y: 0\nz: 0")
            Text("XYZ")
                .font(.caption)
        }
        .frame(maxWidth: .infinity,  minHeight: 120)
        .padding()
        .background(Color.white.opacity(0.6))
        .cornerRadius(10)
    }
}

struct TutorialPopup: View {
    @Binding var showTutorial: Bool
    @State private var isLoadingVideo = true

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Tutorial")
                    .font(.headline)
                    .bold()
                    .padding()
                Spacer()
                Button(action: {
                    showTutorial = false
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .padding(8)
                        .background(Color(.systemGray5))
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal)
            
            ZStack {
                YouTubePlayerView(videoID: "5qap5aO4i9A", isLoading: $isLoadingVideo)
                    .frame(height: 200)
                    .cornerRadius(12)

                if isLoadingVideo {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                }
            }
            .padding(.horizontal)

            Button(action: {
                showTutorial = false
            }) {
                Text("Done")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color(red: 0/255, green: 46/255, blue: 94/255))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            .padding(.bottom, 16)
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(20, corners: [.topLeft, .topRight])
    }
}

struct InitialScanView_Previews: PreviewProvider {
    static var previews: some View {
        InitialScanView()
    }
}
