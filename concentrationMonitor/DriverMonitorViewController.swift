//
//  DriverMonitorViewController.swift
//  concentrationMonitor
//
//  Created by Tommy on 2021/08/19.
//

import UIKit

class DriverMonitorViewController: UIViewController {
    
    // MARK: Variables
    var irisTracker: MPIrisTrackerH!
    var leftEye: Eye?
    var rightEye: Eye?
    let threshold = 0.014672
    let waitingTime = 1.5
    
    var timer: Timer?
    var timerCount = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        irisTracker = MPIrisTrackerH()
        irisTracker.delegate = self
        irisTracker.start()
    }
    
    @objc func timerCounter() {
        timerCount += 0.1
//        print(timerCount)
        if timerCount >= waitingTime {
            print("Not Concentrated")
        }
    }
}


// MARK: Iris Detector Delegate Method
extension DriverMonitorViewController: MPTrackerDelegate {
    func faceMeshDidUpdate(_ tracker: MPIrisTrackerH!, didOutputLandmarks landmarks: [MPLandmark]!, timestamp: Int) {
        self.leftEye = Eye(left: landmarks[33], right: landmarks[133], top: landmarks[159], bottom: landmarks[145])
        self.rightEye = Eye(left: landmarks[398], right: landmarks[263], top: landmarks[386], bottom: landmarks[374])
    }
    
    func irisTrackingDidUpdate(_ tracker: MPIrisTrackerH!, didOutputLandmarks landmarks: [MPLandmark]!, timestamp: Int) {
        if leftEye != nil && rightEye != nil {
            let distanceLeft = leftEye!.calculateDistance(from: landmarks[0])
            let distanceRight = rightEye!.calculateDistance(from: landmarks[5])
            
            print((Double((distanceLeft + distanceRight)) / 2))
            
            if (Double((distanceLeft + distanceRight)) / 2) > threshold && timer == nil {
                timer = Timer.scheduledTimer(
                    timeInterval: 0.1,
                    target: self,
                    selector: #selector(self.timerCounter),
                    userInfo: nil,
                    repeats: true)
                timer?.fire()
            } else if (Double((distanceLeft + distanceRight)) / 2) < threshold && timer != nil {
                timer!.invalidate()
                timer = nil
                timerCount = 0.0
            }
        }
    }
    
    func frameWillUpdate(_ tracker: MPIrisTrackerH!, didOutputPixelBuffer pixelBuffer: CVPixelBuffer!, timestamp: Int) {
        // Pixel Buffer is original image
    }
    
    func frameDidUpdate(_ tracker: MPIrisTrackerH!, didOutputPixelBuffer pixelBuffer: CVPixelBuffer!) {
        // Pixel Buffer is anotated image
    }
}