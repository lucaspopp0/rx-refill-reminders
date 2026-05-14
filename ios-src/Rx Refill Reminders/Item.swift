//
//  Item.swift
//  Rx Refill Reminders
//
//  Created by Lucas Popp on 5/13/26.
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
