//
//  Modal.swift
//  Imbue Systems task
//
//  Created by Kostya Tsyvilko on 18.07.22.
//

import Foundation

/// Enumeration for storing status of payment
enum Status: Int {
    case pending = 0, succeeded
}

/// Model of database structure
struct PaymentModel: Identifiable {
    var id: Int32
    var name: String
    var email: String?
    var phoneNumber: String?
    var amountOfPayment: Double
    var date: Date
    var status: Status
    
    
    /// Converting string formatted date to Swift's Date type
    /// - Parameters:
    ///     - strDate: string format of date
    /// - Returns: Converted Date
    static func convertStringToDate(strDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY, MM d, HH:mm"
        let convertedDate = dateFormatter.date(from: strDate)! //?? Date() // TODO: change
        
        return convertedDate
    }
}
