//
//  DetailEditView.swift
//  Rx Refill Reminders
//
//  Created by Lucas Popp on 5/13/26.
//

import SwiftData
import SwiftUI

struct DetailEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    let cycle: RxCycle

    @State private var draft: RxCycleDraft

    init(cycle: RxCycle) {
        self.cycle = cycle
        _draft = State(initialValue: RxCycleDraft(from: cycle))
    }

    private var baselineDraft: RxCycleDraft {
        RxCycleDraft(from: cycle)
    }

    private var hasDraftChanges: Bool {
        draft != baselineDraft
    }

    var body: some View {
        NavigationStack {
            RxCycleDraftForm(draft: $draft)
                .navigationTitle("Edit Medication")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(role: .cancel) {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                        .accessibilityLabel("Cancel")
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            save()
                        }
                        .disabled(!hasDraftChanges)
                    }
                }
                .interactiveDismissDisabled(hasDraftChanges)
        }
    }

    private func save() {
        cycle.name = draft.name
        cycle.refillIntervalDays = draft.refillIntervalDays
        cycle.pharmacyFillAdvanceDays = draft.pharmacyFillAdvanceDays
        if (try? modelContext.save()) != nil {
            dismiss()
        }
    }
}

#Preview("DetailEditView") {
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

    return DetailEditView(cycle: cycle)
        .modelContainer(container)
}
