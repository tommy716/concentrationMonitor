//
//  ConcentrationAnalysisViewController.swift
//  concentrationMonitor
//
//  Created by Tommy on 2021/08/18.
//

import UIKit

class ConcentrationAnalysisViewController: UIViewController {
    
    // MARK: Variables
    var irisTracker: MPIrisTrackerH!
    var leftEye: Eye?
    var rightEye: Eye?
    let threshold = 0.014672
    let waitingTime = 1.5
    
    var concentrationData: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        irisTracker = MPIrisTrackerH()
        irisTracker.delegate = self
        irisTracker.start()
    }
    
    @IBAction func toResult() {
        self.performSegue(withIdentifier: "toResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResult" {
            let destination = segue.destination as! AnalysisResultViewController
            destination.concentrationData = self.concentrationData
        }
    }
}

// MARK: Iris Detector Delegate Method
extension ConcentrationAnalysisViewController: MPTrackerDelegate {
    func faceMeshDidUpdate(_ tracker: MPIrisTrackerH!, didOutputLandmarks landmarks: [MPLandmark]!, timestamp: Int) {
        self.leftEye = Eye(left: landmarks[33], right: landmarks[133], top: landmarks[159], bottom: landmarks[145])
        self.rightEye = Eye(left: landmarks[398], right: landmarks[263], top: landmarks[386], bottom: landmarks[374])
    }
    
    func irisTrackingDidUpdate(_ tracker: MPIrisTrackerH!, didOutputLandmarks landmarks: [MPLandmark]!, timestamp: Int) {
        if leftEye != nil && rightEye != nil {
            let distanceLeft = leftEye!.calculateDistance(from: landmarks[0])
            let distanceRight = rightEye!.calculateDistance(from: landmarks[5])
            
            if (Double((distanceLeft + distanceRight)) / 2) > threshold {
                concentrationData.append(0)
            } else {
                concentrationData.append(1)
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
