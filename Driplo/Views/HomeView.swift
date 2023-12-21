//
//  HomeView.swift
//  Driplo
//
//  Created by Ali Hodroj on 18/12/2023.
//

import SwiftUI

struct HomeView: View {
    
    // ViewModel
    @StateObject var vm: HomeViewModel = HomeViewModel()
    
    var body: some View {
        // root
        NavigationStack {
            // main container
            ZStack {
                // background color
                Color.main.ignoresSafeArea()
                // inner container
                VStack(spacing: 0) {
                    ProgressSection(vm)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .onAppear {
                // reseting data if new day
                let components = Calendar.current.dateComponents([.day], from: Date.now)
                if vm.lastUpdated != Calendar.current.date(from: components) {
                    vm.leftToDrink = 0
                    UserDefaults.standard.set(0, forKey: "LEFT_TO_DRINK")
                    let components = Calendar.current.dateComponents([.day], from: Date.now)
                    UserDefaults.standard.setValue(Calendar.current.date(from: components), forKey: "LAST_UPDATED")
                }
            }
            .safeAreaInset(edge: .bottom) {
                BottomBar(vm)
            }
            .safeAreaInset(edge: .top) {
                TopBar()
            }
        }
    }
}

@ViewBuilder
func TopBar() -> some View {
    
    // View's Color
    let color: Color = .main
    
    HStack(spacing: 10) {
        // Date
        Text(Date.now, format: .dateTime.day().month())
            .font(.title2)
            .fontWeight(.bold)
            .foregroundStyle(color)
        Spacer()
        // Charts
        //        Button {
        //            // todo
        //        } label: {
        //            Image(systemName: "chart.bar.fill")
        //                .font(.title2)
        //                .foregroundStyle(color)
        //        }
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

@ViewBuilder
func ProgressSection(_ vm: HomeViewModel) -> some View {
    VStack(spacing: 0) {
        // progress bar
        ZStack {
            // background circle
            Circle()
                .stroke(lineWidth: 16)
                .frame(width: 200, height: 200)
                .foregroundStyle(.white.opacity(0.25))
            // progress circle
            Circle()
                .trim(from: 0, to: Double(vm.leftToDrink) / Double(vm.dailyGoal))
                .stroke(style: StrokeStyle(lineWidth: 16, lineCap: .round, lineJoin: .round))
                .rotation(.degrees(90))
                .frame(width: 200, height: 200)
                .foregroundStyle(.white)
        }
        .overlay(alignment: .center) {
            if( Double(vm.leftToDrink) / Double(vm.dailyGoal) < 1) {
                let perc = Float(Double(vm.leftToDrink) / Double(vm.dailyGoal)) * 100
                Text(String(format: "%.f", perc) + "%")
                    .font(.title)
                    .fontDesign(.rounded)
                    .fontWeight(.heavy)
                    .foregroundStyle(.white)
            } else {
                Text("GOAL\nReached\n100%")
                    .font(.title)
                    .fontDesign(.rounded)
                    .fontWeight(.heavy)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
            }
        }
        // Information
        HStack(spacing: 25) {
            // left to drink
            VStack {
                Text(String(vm.leftToDrink) + " " + vm.unit)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                Text("Left to drink")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundStyle(.white)
            }
            //splitter
            VStack { }.frame(width: 2, height: 50).background { Color.white }
            // daily goal
            VStack {
                Text(String(vm.dailyGoal) + " " + vm.unit)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                Text("Daily Goal")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .foregroundStyle(.white)
            }
        }.padding(.top, 30)
        // Drink Button
        Button(action: {
            vm.Drink(Int(vm.selectedCup)!)
        }, label: {
            Text("DRINK")
                .frame(width: 150, height: 35)
                .fontDesign(.rounded)
                .foregroundStyle(.main)
                .background {
                    Color.white.clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.top, 30)
        })
    }.padding(.top, 30)
}

@ViewBuilder
func BottomBar(_ vm: HomeViewModel) -> some View {
    
    let cups = ["100", "200", "300"]
    
    HStack(spacing: 20) {
        ForEach(cups, id: \.self) { cup in
            VStack(spacing: 10) {
                Image("cup")
                    .resizable()
                    .frame(width: 100, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 22))
                    .padding(.top)
                    .onTapGesture {
                        withAnimation {
                            vm.selectedCup = cup
                        }
                    }
                Text(cup + UserDefaults.standard.string(forKey: "UNIT")!)
                    .frame(width: 80)
                    .font(.title3)
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                    .foregroundStyle(vm.selectedCup == cup ? .white : .main)
                    .padding(.vertical, 5)
                    .background {
                        if(vm.selectedCup == cup) {
                            Color.main.clipShape(Capsule())
                        }
                    }
            }
        }
    }
    .frame(maxWidth: .infinity)
    .frame(height: 280)
    .background {
        Color.white.clipShape(RoundedRectangle(cornerRadius: 22)).ignoresSafeArea().shadow(radius: 5)
    }
}
