//
//  PerimeterPointsPopup.swift
//  measure
//
//  Created by Edward Focer on 21/05/25.
//

import SwiftUI

struct PerimeterPointsPopup: View {
    @Binding var isPresented: Bool
    @State private var points: [PointItem] = [
        PointItem(id: UUID(), name: "Point 1", notes: "No notes added"),
        PointItem(id: UUID(), name: "Point 2", notes: "No notes added"),
        PointItem(id: UUID(), name: "Point 3", notes: "No notes added"),
        PointItem(id: UUID(), name: "Point 4", notes: "No notes added"),
    ]
    @State private var isDeleting = false
    @State private var imageName: String = "scan_points_sample"

    var body: some View {
        VStack(spacing: 0) {
            // Header with title and close button
            HStack {
                Text("Review plot drawing")
                    .font(.headline)
                    .bold()
                    .foregroundColor((Color(red: 0/255, green: 46/255, blue: 94/255)))
                Spacer()
                Button(action: {
                    isPresented = false
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.gray)
                        .padding(8)
                        .background(Color(.systemGray5))
                        .clipShape(Circle())
                }
            }
            .padding()

            Divider()

            // Top image placeholder
            Image(imageName)
                .resizable()
                .scaledToFit()
                .padding()

            // Reorderable list
            List {
                ForEach(points) { point in
                    HStack(spacing: 10, content: {
                        Text(point.name)
                            .font(.body)
                            .foregroundColor(Color.black)
                        Spacer()
                        Text(point.notes)
                            .font(.subheadline)
                            .foregroundColor(Color.gray)
                    })
                    .padding(.vertical, 14)
                    .padding(.horizontal, 16)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
                    .listRowInsets(EdgeInsets()) // Remove default padding
                    .padding(.vertical, 4)
                }
                .onMove(perform: move)
                .onDelete(perform: delete)
            }
            .listStyle(PlainListStyle())
            .padding()
            .disabled(isDeleting)
            
            // Save button
            Button(action: {
                // Implement save action
                isPresented = false
            }) {
                Text("Save and continue")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color(red: 0/255, green: 46/255, blue: 94/255))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .padding(.bottom, 16)
            }
            .disabled(isDeleting)

        }
        .background(Color(red: 230/255, green: 234/255, blue: 239/255))
        .cornerRadius(20)
        .shadow(radius: 10)
        .overlay(
            Group {
                if isDeleting {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)

                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)
                }
            }
        )
    }

    private func binding(for point: PointItem) -> Binding<PointItem> {
        guard let index = points.firstIndex(where: { $0.id == point.id }) else {
            fatalError("Point not found")
        }
        return $points[index]
    }

    private func move(from source: IndexSet, to destination: Int) {
        points.move(fromOffsets: source, toOffset: destination)
    }

    private func delete(at offsets: IndexSet) {
        isDeleting = true
        imageName = "updated_scan_sample"
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            points.remove(atOffsets: offsets)
            isDeleting = false
        }
    }
}

struct PerimeterPointsPopup_Previews: PreviewProvider {
    static var previews: some View {
        PerimeterPointsPopup(isPresented: .constant(true))
    }
}
