//
//  LoadingView.swift
//  Driplo
//
//  Created by Ali Hodroj on 17/12/2023.
//

import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        // Main Container
        ZStack {
            // Checking for first app launch
            if(UserDefaults.standard.bool(forKey: "LAUNCHED_BEFORE")) {
                HomeView()
            } else {
                FirstTimeView()
            }
            // Animation
            LoadingAnimation()
        }
    }
}

#Preview {
    LoadingView()
}

struct LoadingAnimation: View {
    
    // Animation States
    @State private var scaleFactor: CGFloat = 1.0
    @State private var tiltFactor: Angle = .degrees(0)
    @State private var fadeFactor: Double = 1.0
    
    var body: some View {
        ZStack {
            // Background Color
            Color.main.ignoresSafeArea()
                .opacity(fadeFactor)
            // App Logo
            Image("AppLogo")
                .resizable()
                .frame(width: 250, height: 250)
                .scaleEffect(scaleFactor)
                .rotationEffect(tiltFactor)
                .opacity(fadeFactor)
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.bouncy(duration: 0.5)) {
                    scaleFactor = 0.75
                    tiltFactor = .degrees(-4)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
                    withAnimation(.bouncy(duration: 2.5)) {
                        scaleFactor = 100
                        fadeFactor = 0
                        tiltFactor = .degrees(90)
                    }
                }
            }
        }
    }
}
