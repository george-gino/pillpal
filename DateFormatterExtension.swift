//
//  DateFormatterExtension.swift
//  PillPal
//
//  Created by George Gino on 6/6/24.
//

import Foundation

extension DateFormatter {
    static let shortDateShortTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}

