//
//  ListView.swift
//  Rx Refill Reminders
//
//  Created by Lucas Popp on 5/13/26.
//

import SwiftData
import SwiftUI

struct ListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \RxCycle.createdAt, order: .reverse) private var cycles: [RxCycle]

    @State private var isPresentingCreateEditor = false
    @State private var isPresentingSettings = false

    var body: some View {
        NavigationStack {
            Group {
                if cycles.isEmpty {
                    ContentUnavailableView(
                        "No medications",
                        systemImage: "pills",
                        description: Text("Tap + to add a medication")
                    )
                } else {
                    List {
                        ForEach(cycles) { cycle in
                            NavigationLink {
                                DetailReadView(cycle: cycle)
                            } label: {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(cycle.name)
                                        .font(.headline)
                                    Text("Every \(cycle.refillIntervalDays) days")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        .onDelete(perform: deleteCycles)
                    }
                }
            }
            .navigationTitle("Medications")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isPresentingSettings = true
                    } label: {
                        Label("Settings", systemImage: "gearshape")
                    }
                }
                if !cycles.isEmpty {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresentingCreateEditor = true
                    } label: {
                        Label("Add Rx cycle", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingSettings) {
                NavigationStack {
                    SettingsView()
                }
            }
            .fullScreenCover(isPresented: $isPresentingCreateEditor) {
                CreateRxCycleEditorView()
            }
        }
    }

    private func deleteCycles(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(cycles[index])
            }
        }
    }
}

#Preview {
    ListView()
        .modelContainer(for: RxCycle.self, inMemory: true)
}
