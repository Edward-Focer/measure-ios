//
//  ProjectDetailsView.swift
//  measure
//
//  Created by Edward Focer on 16/05/25.

import SwiftUI

struct ProjectDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    let project: Project
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            // Segmented Control
            Picker("", selection: $selectedTab) {
                Text("Details").tag(0)
                Text("Photos").tag(1)
                Text("Pool").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            // Content Based on Selected Tab
            if selectedTab == 0 {
                ProjectDetailsTab(project: project)
            } else if selectedTab == 1 {
                ProjectPhotosTab(project: project)
            } else {
                ProjectPoolTab(project: project)
            }
            Spacer()
        }
        .background(Color(.systemGray6)) // Ensure background color for the rest of the screen
        
        // Navigation bar customization
        .navigationBarTitle(project.notes, displayMode: .inline)
        .navigationBarItems(
            leading: Button(action: {
                // Back button action
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .padding(.leading, 2)
                    
                    Text("Back")
                        .foregroundColor(.white)
                }
            },
            trailing: Button(action: {
                // Settings button action
            }) {
                Text("Settings")
                    .foregroundColor(.white)
            }
        )
        .onAppear {
            setupNavigationBar()
        }
    }

    // Custom setup for the navigation bar appearance
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(red: 0/255, green: 46/255, blue: 94/255, alpha: 1) // Deep Sea Blue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
