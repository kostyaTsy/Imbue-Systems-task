//
//  Date extension.swift
//  Imbue Systems task
//
//  Created by Kostya Tsyvilko on 19.07.22.
//

import Foundation

extension Date {
    func formattedDate() -> String {
        let calendar = Calendar.current
        
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
