//
//  EditMedicationView.swift
//  PillPal
//
//  Created by George Gino on 5/30/24.
//

import SwiftUI

struct EditMedicationView: View {
    @Binding var medication: Medication
    @State private var selectedTimes: [DateComponents]

    let timesOptions = Array(1...10) // 1 to 10 times a day
    let unitOptions = ["day", "week", "month"]

    init(medication: Binding<Medication>) {
        self._medication = medication
        self._selectedTimes = State(initialValue: medication.wrappedValue.times)
    }

    var body: some View {
        Form {
            Section(header: Text("Medication Name")) {
                TextField("Name", text: $medication.name)
            }

            Section(header: Text("Frequency")) {
                Stepper("Frequency: \(medication.frequency) times a day", value: $medication.frequency, in: 1...10)
                ForEach(0..<medication.frequency, id: \.self) { index in
                    DatePicker("Time \(index + 1)", selection: Binding<Date>(
                        get: {
                            if index < selectedTimes.count {
                                return Calendar.current.date(from: selectedTimes[index]) ?? Date()
                            } else {
                                return Date()
                            }
                        },
                        set: { newValue in
                            let components = Calendar.current.dateComponents([.hour, .minute], from: newValue)
                            if index < selectedTimes.count {
                                selectedTimes[index] = components
                            } else {
                                selectedTimes.append(components)
                            }
                        }
                    ), displayedComponents: .hourAndMinute)
                }
            }

            Section(header: Text("Image")) {
                if let image = medication.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                } else {
                    Button(action: {
                        showingImagePicker = true
                    }) {
                        Text("Select Image")
                    }
                }
            }
        }
        .navigationTitle("Edit Medication")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $medication.image)
        }
        .onDisappear {
            medication.times = selectedTimes
        }
    }

    @State private var showingImagePicker = false
}
