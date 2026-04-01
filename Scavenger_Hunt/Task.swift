//
//  Task.swift
//  Scavenger_Hunt
//
//  Created by Walter Cuadra on 3/31/26.
//

import SwiftUI
import UIKit
import CoreLocation

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var image: UIImage? = nil
    var imageLocation: CLLocation? = nil

    var isComplete: Bool {
        image != nil
    }
}

extension Task {
    static let mockedTasks: [Task] = [
        Task(title: "Find Something Blue", description: "Take a picture of something blue."),
        Task(title: "Find a Tree", description: "Take a picture of a tree."),
        Task(title: "Find Your Backpack", description: "Take a picture of your backpack.")
    ]
}
