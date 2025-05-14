//
//  SplashView.swift
//  measure
//
//  Created by Edward Focer on 14/05/25.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            HomeView()
        } else {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0/255, green: 46/255, blue: 94/255),
                        Color(red: 51/255, green: 192/255, blue: 224/255)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 210, height: 105)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}
