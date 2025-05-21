//
//  PerimeterPointsView.swift
//  measure
//
//  Created by Edward Focer on 20/05/25.
//

import SwiftUI

struct PerimeterPointsView: View {
    // Dummy state for points count (update as per logic)
    @State private var pointsCount: Int = 0
    @Environment(\.presentationMode) var presentationMode
    @State private var showPerimeterPopup = true

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
                        PointsView()
                    }
                    .padding()
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Status text
                    Text("You need to have 12 points according to the scan")
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.top, 8)
                    
                    Spacer()

                    // Camera target overlay & instructions
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
                    .padding(.bottom, 32)

                    Spacer()
                    
                    // Buttons
                    HStack(spacing: 16) {
                        Button(action: {
                            // Action for Place Point
                            pointsCount += 1
                        }) {
                            Text("Place Point")
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color(red: 0/255, green: 46/255, blue: 94/255))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }

                        Button(action: {
                            // Action for Save
                            // e.g. dismiss or save points
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Save")
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.white.opacity(0.8))
                                .foregroundColor(Color(red: 0/255, green: 46/255, blue: 94/255))
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 32)
                }
                
                if showPerimeterPopup {
                    VStack {
                        Spacer()
                        PerimeterPopup(isPresented: $showPerimeterPopup) {
                            // Handle next action after perimeter popup
                            // For example, navigate or start point capturing flow
                        }
                    }
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: showPerimeterPopup)
                }
            }
            .navigationBarTitle("Perimeter points", displayMode: .inline)
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
        }
    }
}


struct PointsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("1-2 0")
                .bold()
            Text("2-3 0")
            Text("3-4 0")
            Text("4-1 0")
            Text("Points")
                .font(.caption)
        }
        .frame(maxWidth: .infinity, minHeight: 120)
        .padding()
        .background(Color.white.opacity(0.6))
        .cornerRadius(10)
    }
}
