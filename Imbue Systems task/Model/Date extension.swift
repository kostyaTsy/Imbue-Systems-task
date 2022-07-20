//
//  Date extension.swift
//  Imbue Systems task
//
//  Created by Kostya Tsyvilko on 19.07.22.
//

import Foundation

extension Date {
    
    /// Converting Swift's Date to string representation of date
    /// - Returns: converted Date to formats (hours: minutes or month day)
    func formattedDate() -> String {
        let calendar = Calendar.current
        
        // Getting date components to compare to dates by year, month and day
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: self)
        let nowDateComponents = calendar.dateComponents([.year, .month, .day], from: Date())
        
        let dateFormatter = DateFormatter()
        
        if calendar.date(from: dateComponents)! == calendar.date(from: nowDateComponents)! {
            dateFormatter.dateFormat = "h:mm a"
            return dateFormatter.string(from: self)
        }
        else {
            dateFormatter.dateFormat = "MMM dd"
            return dateFormatter.string(from: self)
        }
    }
}
