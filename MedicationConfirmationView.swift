//
//  MedicationConfirmationView.swift
//  PillPal
//
//  Created by George Gino on 6/6/24.
//


import SwiftUI

struct MedicationConfirmationView: View {
    @Binding var isPresented: Bool
    @EnvironmentObject var viewModel: MedicationViewModel
    var medicationName: String

    var body: some View {
        VStack {
            Text("Did you take your medication?")
                .font(.largeTitle)
                .padding()

            HStack(spacing: 20) {
                Button(action: {
                    viewModel.logMedication(name: medicationName)
                    sendEmailNotifications(taken: true)
                    isPresented = false
                }) {
                    Text("Taken")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: {
                    sendEmailNotifications(taken: false)
                    isPresented = false
                }) {
                    Text("Skip")
                        .font(.title)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .padding()
    }

    func sendEmailNotifications(taken: Bool) {
        let subject = "Medication Update"
        let body = taken ? "\(medicationName) was taken." : "\(medicationName) was skipped."

        for email in viewModel.emailRecipients {
            EmailManager.shared.sendEmail(to: email, subject: subject, body: body) { result in
                switch result {
                case .success:
                    print("Email sent successfully to \(email)")
                case .failure(let error):
                    print("Error sending email to \(email): \(error)")
                }
            }
        }
    }
}







