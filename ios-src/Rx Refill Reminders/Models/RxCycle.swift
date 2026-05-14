//
//  RxCycle.swift
//  Rx Refill Reminders
//
//  Created by Lucas Popp on 5/13/26.
//

import Foundation
import SwiftData

@Model
final class RxCycle {
    var name: String
    var refillIntervalDays: Int
    var pharmacyFillAdvanceDays: Int
    var createdAt: Date

    init(
        name: String,
        refillIntervalDays: Int,
        pharmacyFillAdvanceDays: Int,
        createdAt: Date = Date()
    ) {
        self.name = name
        self.refillIntervalDays = refillIntervalDays
        self.pharmacyFillAdvanceDays = pharmacyFillAdvanceDays
        self.createdAt = createdAt
    }
}
