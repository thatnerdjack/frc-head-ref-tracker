//
//  Item.swift
//  frc-head-ref-tracker
//
//  Created by Jack Doherty on 2/27/26.
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
