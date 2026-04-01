//
//  TaskListView.swift
//  Scavenger_Hunt
//
//  Created by Walter Cuadra on 3/31/26.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var store: TaskStore

    var body: some View {
        List {
            ForEach($store.tasks) { $task in
                NavigationLink {
                    TaskDetailView(task: $task)
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: task.isComplete ? "circle.inset.filled" : "circle")
                            .foregroundColor(task.isComplete ? .blue : .gray)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(task.title)
                                .foregroundColor(task.isComplete ? .secondary : .primary)

                            Text(task.description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .navigationTitle("Scavenger Hunt")
    }
}

#Preview {
    NavigationStack {
        TaskListView()
            .environmentObject(TaskStore())
    }
}
