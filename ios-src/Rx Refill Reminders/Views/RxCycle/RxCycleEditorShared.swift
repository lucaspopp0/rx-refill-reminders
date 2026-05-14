//
//  RxCycleEditorShared.swift
//  Rx Refill Reminders
//
//  Created by Lucas Popp on 5/13/26.
//

import SwiftData
import SwiftUI

struct RxCycleDraft: Equatable {
    var name: String
    var refillIntervalDays: Int
    var pharmacyFillAdvanceDays: Int

    static let newMedicationTemplate = RxCycleDraft(
        name: "New cycle",
        refillIntervalDays: 25,
        pharmacyFillAdvanceDays: 3
    )

    init(name: String, refillIntervalDays: Int, pharmacyFillAdvanceDays: Int) {
        self.name = name
        self.refillIntervalDays = refillIntervalDays
        self.pharmacyFillAdvanceDays = pharmacyFillAdvanceDays
    }

    init(from cycle: RxCycle) {
        name = cycle.name
        refillIntervalDays = cycle.refillIntervalDays
        pharmacyFillAdvanceDays = cycle.pharmacyFillAdvanceDays
    }
}

struct RxCycleDraftForm: View {
    @Binding var draft: RxCycleDraft

    var body: some View {
        Form {
            Section("Name") {
                TextField("Name", text: $draft.name)
            }

            Section {
                HStack {
                    Text("\(draft.refillIntervalDays) days after last pickup")
                        .monospacedDigit()
                    Spacer()
                    Stepper(value: $draft.refillIntervalDays, in: 1...120) {
                        EmptyView()
                    }
                    .labelsHidden()
                }
                .accessibilityElement(children: .combine)
            } header: {
                Text("Refill Interval")
            } footer: {
                Text(
                    "How long after your last pickup you become "
                        + "eligible to refill again."
                )
            }

            Section {
                HStack {
                    Text("\(draft.pharmacyFillAdvanceDays) days before pickup")
                        .monospacedDigit()
                    Spacer()
                    Stepper(value: $draft.pharmacyFillAdvanceDays, in: 0...30) {
                        EmptyView()
                    }
                    .labelsHidden()
                }
                .accessibilityElement(children: .combine)
            } header: {
                Text("Pharmacy Fill Reminder")
            } footer: {
                Text(
                    "How long before you're eligible for pickup you want "
                        + "to be reminded to ask the pharmacy to fill it."
                )
            }
        }
    }
}
