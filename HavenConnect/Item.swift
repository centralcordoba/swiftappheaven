//
//  Item.swift
//  HavenConnect
//
//  Created by Emanuel Jimenez on 01/02/2024.
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
