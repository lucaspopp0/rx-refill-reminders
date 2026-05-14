//
//  DetailReadView.swift
//  Rx Refill Reminders
//
//  Created by Lucas Popp on 5/13/26.
//

import SwiftData
import SwiftUI

struct DetailReadView: View {
    var cycle: RxCycle

    @State private var isPresentingEditor = false

    var body: some View {
        Form {
            Section("Name") {
                Text(cycle.name)
            }

            Section {
                Text("\(cycle.refillIntervalDays) days after last pickup")
                    .monospacedDigit()
            } header: {
                Text("Refill Interval")
            } footer: {
                Text(
                    "How long after your last pickup you become "
                        + "eligible to refill again."
                )
            }

            Section {
                Text("\(cycle.pharmacyFillAdvanceDays) days before pickup")
                    .monospacedDigit()
            } header: {
                Text("Pharmacy Fill Reminder")
            } footer: {
                Text(
                    "How long before you're eligible for pickup you want "
                        + "to be reminded to ask the pharmacy to fill it."
                )
            }
        }
        .navigationTitle("Medication")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isPresentingEditor = true
                } label: {
                    Image(systemName: "pencil")
                }
                .accessibilityLabel("Edit")
            }
        }
        .fullScreenCover(isPresented: $isPresentingEditor) {
            DetailEditView(cycle: cycle)
        }
    }
}

#Preview("DetailReadView") {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: RxCycle.self,
        configurations: configuration
    )
    let cycle = RxCycle(
        name: "Example",
        refillIntervalDays: 25,
        pharmacyFillAdvanceDays: 3
    )
    container.mainContext.insert(cycle)

    return NavigationStack {
        DetailReadView(cycle: cycle)
    }
    .modelContainer(container)
}
