//
//  ProjectPoolTab.swift
//  measure
//
//  Created by Edward Focer on 16/05/25.
//

import SwiftUI

struct ProjectPoolTab: View {
    let project: Project
    @State private var showScanOption = false
    
    var body: some View {
        VStack(spacing: 0) {
            // "Scans" header
            HStack {
                Text("Scans")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(Color(red: 0/255, green: 46/255, blue: 94/255))
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            // Scans section styled as table
            VStack(spacing: 0) {
                
                // Header Row
                HStack(spacing: 0) {
                    Text("Added")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(Color(red: 138/255, green: 159/255, blue: 181/255))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 12)
                        .padding(.leading, 16)
                    
                    Text("Scanned By")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(Color(red: 138/255, green: 159/255, blue: 181/255))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 12)
                    
                    Text("Uploaded")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(Color(red: 138/255, green: 159/255, blue: 181/255))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 12)
                        .padding(.trailing, 16)
                }
                .background(Color.white)

                Divider()

                // Data Rows
                ForEach(Array((project.scans ?? []).enumerated()), id: \.element.id) { index, scan in
                    HStack(spacing: 0) {
                        Text(scan.date)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color(red: 0/255, green: 46/255, blue: 94/255))
                            .padding(.vertical, 12)
                            .padding(.leading, 16)

                        Text(scan.scanner)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color(red: 0/255, green: 46/255, blue: 94/255))
                            .padding(.vertical, 12)

                        Text(scan.uploaded ? "Uploaded" : "Not")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color(red: 0/255, green: 46/255, blue: 94/255))
                            .padding(.vertical, 12)
                            .padding(.trailing, 16)
                    }
                    .background(index % 2 == 0 ? Color.white : Color(red: 248/255, green: 248/255, blue: 248/255)) // Zebra stripes

                    Divider()
                }
            }
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(red: 230/255, green: 230/255, blue: 230/255), lineWidth: 1)
            )
            .padding(.horizontal, 16)

            Spacer()

            // Action Buttons
            VStack(spacing: 16) {
                Button(action: {
                    // Upload to Portal
                }) {
                    Text("Upload to Portal")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(red: 0/255, green: 46/255, blue: 94/255))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .font(.system(size: 17, weight: .semibold))
                }

                Button(action: {
                    // Measure the pool
                    showScanOption = true
                }) {
                    Text("Measure the pool")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(red: 0/255, green: 46/255, blue: 94/255), lineWidth: 2)
                        )
                        .foregroundColor(Color(red: 0/255, green: 46/255, blue: 94/255))
                        .font(.system(size: 17, weight: .semibold))
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 20)
        }
        .padding(.top)
        .background(Color(red: 242/255, green: 243/255, blue: 245/255).ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .overlay(
            ZStack {
                if showScanOption {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                showScanOption = false
                            }
                        }

                    ScanOptionsModal {
                        withAnimation {
                            showScanOption = false
                        }
                    }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .zIndex(1)
                }
            }
        )
    }
}
