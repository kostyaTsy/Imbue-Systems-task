//
//  MyLineChartView.swift
//  Imbue Systems task
//
//  Created by Kostya Tsyvilko on 19.07.22.
//

import SwiftUI
import Charts

struct MyLineChartView: UIViewRepresentable {
    
    // Array of point in the chart
    let entries: [ChartDataEntry]
    
    func makeUIView(context: Context) -> LineChartView {
        return LineChartView()
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        let dataSet = LineChartDataSet(entries: entries)
        
        // MARK: сustomizing appearance of data
        dataSet.label = "Amount of payments"
        dataSet.colors = [.label]
        dataSet.lineWidth = 2.0
        dataSet.drawValuesEnabled = false
        dataSet.drawCirclesEnabled = false
        dataSet.mode = .horizontalBezier // TODO: change
        
        // Number formatter to right axis
        let rightAxisFormatter = NumberFormatter()
        rightAxisFormatter.minimumFractionDigits = 0
        rightAxisFormatter.maximumFractionDigits = 1
        rightAxisFormatter.negativePrefix = "$"
        rightAxisFormatter.positivePrefix = "$"
        
        // MARK: сustomizing appearance of chart
        uiView.data = LineChartData(dataSet: dataSet)
        
        // Axis customization
        uiView.leftAxis.enabled = false
        uiView.xAxis.labelPosition = .bottom
        uiView.xAxis.drawGridLinesEnabled = false // remove xAxis grid
        uiView.xAxis.labelTextColor = .gray
        //uiView.xAxis.valueFormatter = DefaultAxisValueFormatter(formatter: )
        uiView.rightAxis.gridLineDashLengths = [10, 10]
        uiView.rightAxis.drawGridLinesEnabled = true
        uiView.rightAxis.valueFormatter = DefaultAxisValueFormatter(formatter: rightAxisFormatter)
        uiView.rightAxis.labelTextColor = .gray
        
        // Interaction with chart
        uiView.doubleTapToZoomEnabled = false
        uiView.dragEnabled = true
        uiView.setScaleEnabled(true)
        uiView.pinchZoomEnabled = true
        
        // Legend icon style
        uiView.legend.form = .circle
        uiView.legend.formSize = 10.0
        
        
        // Marker to showing values by tapping on the line chart
        let marker = BalloonMarker(color: UIColor(white: 180/255, alpha: 1),
                                   font: .systemFont(ofSize: 12),
                                   textColor: .white,
                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = uiView
        marker.minimumSize = CGSize(width: 80, height: 40)
        uiView.marker = marker
    }
    
}

struct MyLineChartView_Previews: PreviewProvider {
    static let sampleData: [ChartDataEntry] = [
        ChartDataEntry(x: 0.0, y: 10.0),
        ChartDataEntry(x: 1.0, y: 5.0),
        ChartDataEntry(x: 2.0, y: 7.0),
        ChartDataEntry(x: 3.0, y: 5.0),
        ChartDataEntry(x: 4.0, y: 10.0),
        ChartDataEntry(x: 5.0, y: 6.0),
        ChartDataEntry(x: 6.0, y: 5.0),
        ChartDataEntry(x: 7.0, y: 12.0),
        ChartDataEntry(x: 8.0, y: 4.0),
        ChartDataEntry(x: 9.0, y: 8.0)
    ]

    static var previews: some View {
        MyLineChartView(entries: sampleData)
            .preferredColorScheme(.dark)
    }
}
