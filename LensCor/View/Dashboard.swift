//
//  Dashboard.swift
//  LensCor
//
//  Created by Akash Saxena on 11/06/24.
//

import Foundation
import SwiftUI
import SwiftUICharts

struct Dashboard: View {
   
    var data: PieChartData
   
    init(data: PieChartData) {
        self.data = data
    }
    
    
    var body: some View {
        VStack {
            PieChart(chartData: data)
                .touchOverlay(chartData: data)
                .headerBox(chartData: data)
                .legends(chartData: data, columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())])
                .frame(minWidth: 150, maxWidth: 900, minHeight: 150, idealHeight: 500, maxHeight: 600, alignment: .center)
                .id(data.id)
                .padding(.horizontal)
        }
    }
    
}

extension Dashboard {
//    static func makeData() -> PieChartData {
//        
//        let data = PieDataSet(
//            dataPoints: [
//                PieChartDataPoint(value: 0, description: "Priority",   colour: .orange  , label: .icon(systemName: "1.square", colour: .white, size: 30)),
//                PieChartDataPoint(value: 0, description: "Completed",   colour: .green   , label: .icon(systemName: "2.square", colour: .white, size: 30)),
//                PieChartDataPoint(value: 0, description: "Not Done", colour: .red, label: .icon(systemName: "3.square", colour: .white, size: 30)),
//                
//            ],
//            legendTitle: "Data")
//        
//        return PieChartData(dataSets: data,
//                            metadata: ChartMetadata(title: "Tasks", subtitle: "Dev Bandwidth"),
//                            chartStyle: PieChartStyle(infoBoxPlacement: .header))
//    }
}
