//
//  MedicationListView.swift
//  PillPal
//
//  Created by George Gino on 5/30/24.
//



import SwiftUI

struct MedicationListView: View {
    @ObservedObject var viewModel: MedicationViewModel
    @State private var medicationName: String = ""
    @State private var frequency: Int = 1 // Default to once a day
    @State private var selectedTimes: [DateComponents] = [] // Times to take the medication

    var body: some View {
        VStack {
            Text("Medication List")
                .font(.largeTitle)
                .padding()

            TextField("Enter medication name", text: $medicationName)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.words)
                .disableAutocorrection(true)

            Stepper("Frequency: \(frequency) times a day", value: $frequency, in: 1...24)

            ForEach(0..<frequency, id: \.self) { index in
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

            Button(action: {
                if !medicationName.isEmpty {
                    let newMedication = Medication(name: medicationName, frequency: frequency, times: selectedTimes)
                    viewModel.medications.append(newMedication)

                    for time in selectedTimes {
                        NotificationManager.shared.scheduleNotification(
                            title: "Pill Reminder",
                            body: "Time to take your medication: \(medicationName)",
                            at: time
                        )
                    }

                    medicationName = ""
                    frequency = 1
                    selectedTimes = []
                }
            }) {
                Text("Add Medication")
                    .font(.title)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.bottom)

            List {
                ForEach(viewModel.medications) { medication in
                    NavigationLink(destination: EditMedicationView(medication: binding(for: medication))) {
                        Text(medication.name)
                    }
                }
                .onDelete(perform: deleteMedication)
            }
        }
        .padding()
    }

    private func binding(for medication: Medication) -> Binding<Medication> {
        guard let index = viewModel.medications.firstIndex(where: { $0.id == medication.id }) else {
            fatalError("Medication not found")
        }
        return $viewModel.medications[index]
    }

    func deleteMedication(at offsets: IndexSet) {
        viewModel.medications.remove(atOffsets: offsets)
    }
}

