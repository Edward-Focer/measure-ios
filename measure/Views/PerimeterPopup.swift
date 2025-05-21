//
//  PerimeterPopup.swift
//  measure
//
//  Created by Edward Focer on 20/05/25.
//

import SwiftUI

struct PerimeterPopup: View {
    @Binding var isPresented: Bool
    var onNext: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Spacer()
            Text("Perimeter")
                .font(.title)
                .bold()
                .padding()
                .foregroundColor(Color(red: 0/255, green: 46/255, blue: 94/255))

            ScrollView {
                VStack(spacing: 12) {
                    Text("""
                        To measure the pool’s perimeter, place the base of the AR Stick at approximate water’s edge and tap Add Point.

                        Straight sections only require 1 or 2 points. Rounded corners and free-form pools require more points to accurately capture the pool shape.
                        """)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)

                    Image("perimeter_sample")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
            }

            Button(action: {
                onNext()
                isPresented = false
            }) {
                Text("Next")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color(red: 0/255, green: 46/255, blue: 94/255))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            .padding(.bottom, 16)
        }
        .background(Color.white)
        .cornerRadius(20, corners: [.topLeft, .topRight])
        .shadow(radius: 10)
        .padding(.top, 40)
    }
}
