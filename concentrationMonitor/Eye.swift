//
//  Eye.swift
//  concentrationMonitor
//
//  Created by Tommy on 2021/08/18.
//

import Foundation
import Foundation

class Eye {
    var leftEdge: MPLandmark!
    var rightEdge: MPLandmark!
    var topEdge: MPLandmark!
    var bottomEdge: MPLandmark!
    
    init(left: MPLandmark, right: MPLandmark, top: MPLandmark, bottom: MPLandmark) {
        self.leftEdge = left
        self.rightEdge = right
        self.topEdge = top
        self.bottomEdge = bottom
    }
    
    func calculateDistance(from: MPLandmark) -> Float {
        let centerX = (leftEdge.x + rightEdge.x) / 2
        let centerY = (topEdge.y + bottomEdge.y) / 2
        let distance = sqrt(pow((centerX - from.x), 2) + pow((centerY - from.y), 2))
        return distance
    }
}
