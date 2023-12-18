//
//  HomeView.swift
//  Driplo
//
//  Created by Ali Hodroj on 18/12/2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Text(UserDefaults.standard.string(forKey: "KLEB") ?? "")
        Text(UserDefaults.standard.string(forKey: "UNIT") ?? "")
    }
}

#Preview {
    HomeView()
}
