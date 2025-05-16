//
//  ProjectPoolTab.swift
//  measure
//
//  Created by Edward Focer on 16/05/25.
//

import SwiftUI

struct ProjectPoolTab: View {
    let project: Project

    var body: some View {
        VStack {
            List(project.scans ?? []) { scan in
                HStack {
                    Text(scan.date)
                    Spacer()
                    Text(scan.scanner)
                    Spacer()
                    Text(scan.uploaded ? "Uploaded" : "Not Uploaded")
                        .foregroundColor(scan.uploaded ? .green : .red)
                }
            }
            .listStyle(PlainListStyle())
            
            // Action Buttons
            VStack(spacing: 16) {
                // Upload to Portal Button
                Button(action: {
                    // Upload to Portal action
                }) {
                    Text("Upload to Portal")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0/255, green: 46/255, blue: 94/255)) // Deep Sea Blue
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .font(.system(size: 17, weight: .semibold))
                }
                
                // Measure the pool Button
                Button(action: {
                    // Measure Pool action
                }) {
                    Text("Measure the pool")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0/255, green: 46/255, blue: 94/255)) // Deep Sea Blue
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .font(.system(size: 17, weight: .semibold))
                }
            }
            .padding([.leading, .trailing], 16)
            .padding(.top, 10)

        }
        .padding()
        .navigationTitle(project.notes)
        .navigationBarBackButtonHidden(true)
    }
}
