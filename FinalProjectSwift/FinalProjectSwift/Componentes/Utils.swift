//
//  Utils.swift
//  FinalProjectSwift
//
//  Created by Juan jose Morales on 24/7/24.
//

import Foundation
import SwiftUI

func formatChatCreationDate(_ dateTime: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    if let date = dateFormatter.date(from: dateTime) {
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "dd/MM/yyyy"
        return dateFormatterOutput.string(from: date)
    }
    return ""
}

func getTime(from dateTime: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    if let date = dateFormatter.date(from: dateTime) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        return timeFormatter.string(from: date)
    }
    return ""
}
