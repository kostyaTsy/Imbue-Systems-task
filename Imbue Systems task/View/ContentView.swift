//
//  ContentView.swift
//  Imbue Systems task
//
//  Created by Kostya Tsyvilko on 18.07.22.
//

import SwiftUI
import Charts

struct ContentView: View {
    @ObservedObject var dbManager = DBManager.manager
    
    // MARK: vars to displaying errors in DBManager
    @State var errorMsg: String = ""
    @State var errorOccurred: Bool = false
    
    // MARK: data set to display line chart
    @State var dataSet = [ChartDataEntry]()
    @State var monthInd: Int = 6
    
    var monthName: String {
        let month = Months(rawValue: monthInd)!
        switch month {
        case .Jan:
            return "January"
        case .Feb:
            return "February"
        case .Mar:
            return "March"
        case .Apr:
            return "April"
        case .May:
            return "May"
        case .Jun:
            return "June"
        case .Jul:
            return "July"
        case .Aug:
            return "August"
        case .Sep:
            return "September"
        case .Oct:
            return "October"
        case .Nov:
            return "November"
        case .Dec:
            return "December"
        }
    }
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Payment Dashboard")
                    .font(.largeTitle)
                
                Divider()
                    .frame(height: 2)
                    .overlay(.black)
                
                // Chart navigation
                HStack {
                    // Left arrow button
                    Button {
                        decreaseMonth()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .padding(arrowButtonPadding)
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .clipShape(Circle())
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    Text(monthName)
                        .font(.system(size: 20))
                    
                    Spacer()
                    
                    // Right arrow button
                    Button {
                        increaseMonth()
                    } label: {
                        Image(systemName: "chevron.forward")
                            .padding(arrowButtonPadding)
                            .foregroundColor(.white)
                            .background(Color.gray)
                            .clipShape(Circle())
                    }
                    .padding(.trailing)
                    
                }
                
                // Line chart
                if dataSet.count != 0 {
                    MyLineChartView(entries: dataSet)
                        .frame(height: geometry.size.height / 3)
                }
                
                List(dbManager.paymentsInfo) {item in
                    VStack {
                        PaymentCellView(paymentInfo: item)
                    }
                }
                .listStyle(.inset)
                
                
            }
            .alert(errorMsg, isPresented: $errorOccurred, actions: {
                Button("OK", role: .cancel) { }
            })
            .onAppear {
                do {
                    try dbManager.getDBData()
                    
                    dataSet = ChartData.generateChartData(month: Months(rawValue: monthInd)!, data: dbManager.paymentsInfo)
                }
                catch SQLiteError.DatabaseNotOpened(let msg) {
                    errorMsg = msg
                    errorOccurred.toggle()
                }
                catch {
                    errorMsg = error.localizedDescription
                    errorOccurred.toggle()
                }
            }
        }
    }
    
    // Right arrow button action
    func increaseMonth() {
        if monthInd >= maxMonthVal {
            monthInd = minMonthVal
        }
        else {
            monthInd += 1
        }
        
        dataSet = ChartData.generateChartData(month: Months(rawValue: monthInd)!, data: dbManager.paymentsInfo)
    }
    
    
    // Left arrow button action
    func decreaseMonth() {
        if monthInd <= minMonthVal {
            monthInd = maxMonthVal
        }
        else {
            monthInd -= 1
        }
        
        dataSet = ChartData.generateChartData(month: Months(rawValue: monthInd)!, data: dbManager.paymentsInfo)
    }
    
    // MARK: constants
    let minMonthVal = 5
    let maxMonthVal = 6
    let arrowButtonPadding: CGFloat = 6
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
