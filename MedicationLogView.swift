//
//  MedicationLogView.swift
//  PillPal
//
//  Created by George Gino on 6/6/24.
//

import SwiftUI

import Foundation

struct MedicationLog: Identifiable {
    let id = UUID()
    let medicationName: String
    let dateTaken: Date
}



