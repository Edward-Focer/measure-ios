//
//  HomeView.swift
//  measure
//
//  Created by Edward Focer on 14/05/25.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab = 0
    @State private var showCreateProject = false

    let tabs = ["Active", "Uploaded"]
    let projects = [
        Project(title: "Garry Taylor", date: "08.29.2023 at 11:25 AM", imageName: "pool_1"),
        Project(title: "Garry Taylor", date: "08.29.2023 at 11:25 AM", imageName: "pool_2"),
        Project(title: "Garry Taylor", date: "08.29.2023 at 11:25 AM", imageName: "pool_3")
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Custom Header
                HStack {
                    Text("Projects")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Button("+ New project") {
                        showCreateProject = true
                    }
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.white)
                    .sheet(isPresented: $showCreateProject) {
                        CreateNewProjectView()
                            .presentationDetents([.fraction(0.80)])
                            .presentationDragIndicator(.visible)
                    }
                }
                .padding()
                .background(Color(red: 0/255, green: 46/255, blue: 94/255)) // Deep Sea 100%

                // Tab Picker
                Picker("", selection: $selectedTab) {
                    ForEach(0..<tabs.count) { index in
                        Text(self.tabs[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // Section Header
                HStack {
                    Text("Active Projects")
                        .font(.headline)
                    Spacer()
                    Button("Sort") {
                        // Sorting action
                    }
                    .foregroundColor(Color(red: 255/255, green: 99/255, blue: 71/255)) // Tomato red
                }
                .padding(.horizontal)

                // Project Cards List
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(projects) { project in
                            ProjectCard(project: project)
                        }
                    }
                    .padding()
                }

                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}
