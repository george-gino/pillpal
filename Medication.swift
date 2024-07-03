//
//  Medication.swift
//  PillPal
//
//  Created by George Gino on 6/6/24.
//

import Foundation
import UIKit

struct Medication: Identifiable {
    let id = UUID()
    var name: String
    var frequency: Int // Number of times per day
    var times: [DateComponents] // The times of the day to take the medication
    var image: UIImage?
}

