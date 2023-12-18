//
//  HomeView.swift
//  Driplo
//
//  Created by Ali Hodroj on 18/12/2023.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        // root
        NavigationStack {
            // main container
            ZStack {
                // background color
                Color.main.ignoresSafeArea()
                // inner container
                VStack {
                    TopBar()
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
        }
    }
}

#Preview {
    HomeView()
}

@ViewBuilder
func TopBar() -> some View {
    
    var color: Color = .main
    
    HStack(spacing: 10) {
        // Date
        Text(Date.now, format: .dateTime.day().month())
            .font(.title2)
            .fontWeight(.bold)
            .foregroundStyle(color)
        
        Spacer()
        
        // Charts
        Button {
            // todo
        } label: {
            Image(systemName: "chart.bar.fill")
                .font(.title2)
                .foregroundStyle(color)
        }
        
        // Settings
        Button {
            // todo
        } label: {
            Image(systemName: "gearshape.fill")
                .font(.title2)
                .foregroundStyle(color)
        }
    }
    .frame(maxWidth: .infinity)
    .padding(.vertical)
    .padding(.horizontal, 25)
    .background {
        Color.white.clipShape(RoundedRectangle(cornerRadius: 22)).ignoresSafeArea().shadow(radius: 5)
    }
}

