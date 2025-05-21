//
//  ScanCompletionPopup.swift
//  measure
//
//  Created by Edward Focer on 20/05/25.
//

import SwiftUI

struct ScanCompletionPopup: View {
    var onStartCapture: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text("Perimeter scan complete!")
                .font(.title)
                .bold()
                .padding(.top)
                .foregroundColor(Color(red: 0/255, green: 46/255, blue: 94/255))

            Image("perimeter_scan_complete")
                .resizable()
                .scaledToFit()
                .foregroundColor(.green)
                .padding()

            Button(action: onStartCapture) {
                Text("Start capturing points")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(Color(red: 0/255, green: 46/255, blue: 94/255))
                    .cornerRadius(6)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 10)
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(20, corners: [.topLeft, .topRight])
    }
}
