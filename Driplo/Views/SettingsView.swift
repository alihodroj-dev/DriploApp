//
//  SettingsView.swift
//  Driplo
//
//  Created by Ali Hodroj on 21/12/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var sheetPresented: Bool = false
    @State private var datePicked: Date = Date()
    
    var body: some View {
        VStack {
            // notifications list
            List {
                Section("Notifications") {
                    
                }
            }
            .navigationTitle("Settings")
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        sheetPresented = true
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            })
        }
        .sheet(isPresented: $sheetPresented, content: {
            VStack(spacing: 20) {
                DatePicker("Time", selection: $datePicked, displayedComponents: .hourAndMinute)
                    .padding(.horizontal, 80)
                Button("Add") {
                    
                }
            }
            .padding()
            .presentationDetents([.height(200)])
        })
    }
}

#Preview {
    SettingsView()
}

func addNotification(time: Date) {
    let content = UNMutableNotificationContent()
    content.title = "Driplo Reminder"
    content.body = "It's time to drink!"
    
    
    
    
}

