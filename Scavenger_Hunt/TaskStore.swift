//
//  TaskStore.swift
//  Scavenger_Hunt
//
//  Created by Walter Cuadra on 3/31/26.
//

import SwiftUI
import Combine
import UIKit
import CoreLocation

final class TaskStore: ObservableObject {
    @Published var tasks: [Task]

    init() {
        self.tasks = Task.mockedTasks
    }

    func updateTask(taskID: UUID, image: UIImage, location: CLLocation?) {
        guard let index = tasks.firstIndex(where: { $0.id == taskID }) else { return }
        tasks[index].image = image
        tasks[index].imageLocation = location
    }
}
