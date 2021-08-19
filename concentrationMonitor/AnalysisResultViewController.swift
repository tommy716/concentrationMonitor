//
//  AnalysisResultViewController.swift
//  concentrationMonitor
//
//  Created by Tommy on 2021/08/19.
//

import UIKit

class AnalysisResultViewController: UIViewController {
    
    var concentrationData: [Int] = []
    var time: Double!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(Float(concentrationData.reduce(0, +)) / Float(concentrationData.count))
    }
}
