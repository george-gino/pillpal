//
//  ContentView.swift
//  PillPal
//
//  Created by George Gino on 5/30/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var medicationViewModel = MedicationViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Spacer() // Pushes content to the top

                Text("PillPal")
                    .font(.largeTitle)
                    .padding()

                NavigationLink(destination: MedicationListView(viewModel: medicationViewModel)) {
                    Text("Add Medication")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Spacer() // Pushes content up from the bottom
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView().environmentObject(medicationViewModel)) {
                        Image(systemName: "gearshape.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .environmentObject(medicationViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


