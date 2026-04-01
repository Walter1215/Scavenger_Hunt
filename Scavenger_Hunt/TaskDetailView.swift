//
//  TaskDetailView.swift
//  Scavenger_Hunt
//
//  Created by Walter Cuadra on 3/31/26.
//

import SwiftUI
import MapKit

struct TaskDetailView: View {
    @Binding var task: Task
    @State private var showPhotoPicker = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 8) {
                    Image(systemName: task.isComplete ? "circle.inset.filled" : "circle")
                        .foregroundColor(task.isComplete ? .blue : .gray)

                    Text(task.isComplete ? "Complete" : "Incomplete")
                        .foregroundColor(task.isComplete ? .blue : .gray)
                        .fontWeight(.semibold)
                }

                Text(task.title)
                    .font(.title)
                    .fontWeight(.bold)

                Text(task.description)
                    .foregroundColor(.secondary)

                if let image = task.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }

                if !task.isComplete {
                    Button("Attach Photo") {
                        showPhotoPicker = true
                    }
                    .buttonStyle(.borderedProminent)
                }

                if let location = task.imageLocation {
                    Text("Photo Location")
                        .font(.headline)

                    Map(initialPosition: .region(
                        MKCoordinateRegion(
                            center: location.coordinate,
                            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                        )
                    )) {
                        Marker(task.title, coordinate: location.coordinate)
                    }
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding()
        }
        .navigationTitle("Task Details")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showPhotoPicker) {
            PhotoPicker { image, location in
                task.image = image
                task.imageLocation = location
            }
        }
    }
}

#Preview {
    NavigationStack {
        TaskDetailView(task: .constant(Task.mockedTasks[0]))
    }
}
