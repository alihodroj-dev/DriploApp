//
//  FirstTimeView.swift
//  Driplo
//
//  Created by Ali Hodroj on 17/12/2023.
//

import SwiftUI

enum WeightUnit: String, Identifiable, CaseIterable {
    case KG
    case LB
    var id: Self { self }
}

struct FirstTimeView: View {
    
    @State private var weight: String = ""
    @State private var selectedUnit: WeightUnit = .KG
    @FocusState private var weightFocused: Bool
    @State private var goHome: Bool = false
    
    var body: some View {
        // Main Container
        NavigationStack {
            ZStack {
                // Background Color
                Color.main.ignoresSafeArea()
                    .onTapGesture { weightFocused = false }
                // Inner Container
                VStack(spacing: 5) {
                    // App Logo
                    Image("AppLogo")
                        .resizable()
                        .frame(width: 250, height: 250)
                        .offset(y: 30)
                    // App Title
                    Text("Driplo")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                    // Header
                    Text("Looks like it's your first time here. Please enter your weight to calculate the amount of water you need per day.")
                        .foregroundStyle(.black)
                        .font(.title3)
                        .padding(30)
                        .background { RoundedRectangle(cornerRadius: 12).foregroundStyle(.white).padding() }
                    // Weight Input
                    HStack(spacing: 10) {
                        // Weight Field
                        TextField(text: $weight) {
                            Text(weight == "" ? "Weight" : "")
                                .foregroundStyle(.gray)
                        }
                        .frame(height: 40)
                        .padding(.leading, 15)
                        .foregroundStyle(.black)
                        .background { RoundedRectangle(cornerRadius: 12).foregroundStyle(.white) }
                        .keyboardType(.numberPad)
                        .focused($weightFocused)
                        // Unit Picker
                        Picker("", selection: $selectedUnit) {
                            ForEach(WeightUnit.allCases) { unit in
                                Text(unit.rawValue)
                            }
                        }
                        .frame(width: 100, height: 40)
                        .background { RoundedRectangle(cornerRadius: 12).foregroundStyle(.white) }
                    }.padding(.horizontal, 30)
                    // Submit
                    Button("Calculate") {
                        UserDefaults.standard.set(weight, forKey: "KLEB")
                        UserDefaults.standard.set(selectedUnit.rawValue, forKey: "UNIT")
                        goHome = true
                    }
                    .frame(width: 100, height: 35)
                    .background { RoundedRectangle(cornerRadius: 12).foregroundStyle(.white) }
                    .foregroundStyle(.main)
                    .padding()
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }.navigationDestination(isPresented: $goHome) {
                HomeView().navigationBarBackButtonHidden()
            }
        }
    }
}

#Preview {
    FirstTimeView()
}
