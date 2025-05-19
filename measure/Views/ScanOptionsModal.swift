//
//  ScanOptionsModal.swift
//  measure
//
//  Created by Edward Focers on 19/05/25.
//

import SwiftUI

struct ScanOptionsModal: View {
    var onClose: () -> Void
    @State private var selectedTab = 0

    var body: some View {
        VStack(spacing: 16) {
            // Top bar with close button
            HStack {
                // Title
                Text("Scan Option")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(red: 0/255, green: 46/255, blue: 94/255))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                Spacer()
                Button(action: onClose) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .padding(8)
                        .background(Color(.systemGray5))
                        .clipShape(Circle())
                }
            }
            .padding(.top, 10)
            .padding(.trailing, 20)

            // Segmented Picker
            Picker("", selection: $selectedTab) {
                Text("Perimeter").tag(0)
                Text("Point").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            // Tab Content
            if selectedTab == 0 {
                PerimeterScanView()
            } else {
                PointScanView()
            }

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(20, corners: [.topLeft, .topRight])
    }
}

struct PerimeterScanView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image("scan_perimeter_sample")
                .resizable()
                .scaledToFit()
                .padding()

            HStack(spacing: 16) {
                HStack(spacing: 4) {
                    Circle().fill(Color.blue).frame(width: 10, height: 10)
                    Text("Perimeter").font(.caption)
                }
                HStack(spacing: 4) {
                    Circle().fill(Color.red).frame(width: 10, height: 10)
                    Text("LM_002_WALL").font(.caption)
                }
                HStack(spacing: 4) {
                    Circle().fill(Color.green).frame(width: 10, height: 10)
                    Text("LM_003_Diving_Board").font(.caption)
                }
            }
            .padding(.bottom)
        }
    }
}

struct PointScanView: View {
    var body: some View {
        VStack(spacing: 12) {
            // Top image
            Image("scan_points_sample")
                .resizable()
                .scaledToFit()
                .frame(height: 220)
                .padding(.top)

            // Point rows
            ForEach(1...4, id: \.self) { index in
                HStack {
                    Text("Point \(index)")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                    Spacer()
                    Text("No notes added")
                        .font(.system(size: 14))
                        .foregroundColor(Color.gray)
                }
                .padding()
                .background(Color(red: 242/255, green: 243/255, blue: 245/255)) // Light gray bg
                .cornerRadius(10)
                .padding(.horizontal)
            }

            // Edit Button
            Button("Edit") {
                // Handle edit
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color(red: 0/255, green: 46/255, blue: 94/255)) // Deep Sea Blue
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding(.horizontal)
            .padding(.top, 8)
        }
    }
}
