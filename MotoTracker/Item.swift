//
//  Item.swift
//  MotoTracker
//
//  Created by William Gyrulf on 2025-05-13.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
