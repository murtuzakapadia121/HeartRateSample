//
//  ViewController.swift
//  HeartBeatiODemo
//
//  Created by IOS on 29/03/23.
//

import UIKit
import Charts

final class ViewController: UIViewController {
    
    // MARK: - Local variables
    weak var lineChart: LineChartView?
    var entries = [ChartDataEntry]()
    var dataSet = LineChartDataSet()
    var chartData = LineChartData()
    var timer = Timer()
    var x = 10

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createChart()
        startTimer()
    }
    
    // MARK: - Helper functions
    /// update chart every time data is added.
    @objc func updateValue() {
        entries.removeFirst()
        entries.append(ChartDataEntry(x: Double(x), y: Double.random(in: FileConstant.axisMinimum...FileConstant.axisMaximum)))
        
        dataSet = LineChartDataSet(entries: entries)
        chartData = LineChartData(dataSet: dataSet)
        lineChart?.data = chartData
        lineChart?.notifyDataSetChanged()
        x = x + 1
        debugPrint(entries)
    }

    /// Start Timer to send dummy data every 1 sec
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateValue), userInfo: nil, repeats: true)
    }
    
    //MARK: - Setup UI
    /// Create line chart view
    private func createChart() {
        let lineChart = LineChartView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: (view.frame.size.width)/1.5))
        
        let xAxis = lineChart.xAxis
        xAxis.drawGridLinesEnabled = false
        xAxis.drawAxisLineEnabled = false
        
        for x in 0..<10 {
            entries.append(ChartDataEntry(x: Double(x), y: Double.random(in: FileConstant.axisMinimum...FileConstant.axisMaximum)))
        }
        dataSet = LineChartDataSet(entries: entries)
        chartData = LineChartData(dataSet: dataSet)
        lineChart.data = chartData
        lineChart.leftAxis.axisMaximum = FileConstant.axisMinimum
        lineChart.leftAxis.axisMaximum = FileConstant.axisMaximum
        lineChart.rightAxis.axisMinimum = FileConstant.axisMinimum
        lineChart.rightAxis.axisMaximum = FileConstant.axisMaximum
        view.addSubview(lineChart)
        lineChart.center = view.center
        self.lineChart = lineChart
    }
    
}

extension ViewController {
    
    struct FileConstant {
        static let axisMinimum: Double = 50
        static let axisMaximum: Double = 200
    }
}
