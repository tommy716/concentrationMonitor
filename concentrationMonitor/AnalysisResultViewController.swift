//
//  AnalysisResultViewController.swift
//  concentrationMonitor
//
//  Created by Tommy on 2021/08/19.
//

import UIKit

class AnalysisResultViewController: UIViewController {
    
    var concentrationData: [Int] = []
    var time: Int!
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let result = (Float(concentrationData.reduce(0, +)) / Float(concentrationData.count)) * 100
        
        resultLabel.text = String(format: "%.01f", result) + "%"
        timeLabel.text = "\(time / 60):\(String(format: "%02d", (time % 60)))"
    }
}
