//
//  ChartData.swift
//  Imbue Systems task
//
//  Created by Kostya Tsyvilko on 20.07.22.
//

import Foundation
import Charts

enum Months: Int {
    case Jan = 1, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec
}

class ChartData {
    
    /// Generating data set to line chart from array of PaymentModel
    /// - Parameters:
    ///     - month: month of statistics on the line chart
    ///     - data: array of PaymentModel
    /// - Returns:sorted data set to line chart
    static func generateChartData(month: Months, data: [PaymentModel]) -> [ChartDataEntry] {
        var dataSet = [ChartDataEntry]()
        
        let monthValue: Int = month.rawValue
        
        // Dictionary for storing payments by day
        var dataDict = [Int: Double]()
        
        // Counting payments per day
        for item in data {
            let calendar = Calendar.current
            let dateComponents = calendar.dateComponents([.month, .day], from: item.date)
            
            if dateComponents.month! == monthValue {
                if dataDict[dateComponents.day!] != nil {
                    dataDict[dateComponents.day!]! += item.amountOfPayment
                }
                else {
                    dataDict[dateComponents.day!] = item.amountOfPayment
                }
            }
        }
        
        // Finding amount of days in current month of 2022 year
        let dateComponents = DateComponents(year: 2022, month: monthValue)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count

        // Filling data set by counted values from dictionary
        for i in 1...numDays {
            if let val = dataDict[i] {
                dataSet.append(ChartDataEntry(x: Double(i), y: round(val * 100) / 100))
            }
            else {
                dataSet.append(ChartDataEntry(x: Double(i), y: 0.0))
            }
        }
        
        return dataSet.sorted {$0.x < $1.x}
    }
}
