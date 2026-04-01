//
//  PhotoPicker.swift
//  Scavenger_Hunt
//
//  Created by Walter Cuadra on 3/31/26.
//

import SwiftUI
import PhotosUI
import Photos
import CoreLocation
import UIKit

struct PhotoPicker: UIViewControllerRepresentable {
    var onImagePicked: (UIImage, CLLocation?) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(onImagePicked: onImagePicked)
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = .images
        config.selectionLimit = 1
        config.preferredAssetRepresentationMode = .current

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }

    final class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let onImagePicked: (UIImage, CLLocation?) -> Void

        init(onImagePicked: @escaping (UIImage, CLLocation?) -> Void) {
            self.onImagePicked = onImagePicked
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let result = results.first else { return }

            let location: CLLocation? = {
                guard let assetID = result.assetIdentifier else { return nil }
                return PHAsset.fetchAssets(withLocalIdentifiers: [assetID], options: nil)
                    .firstObject?
                    .location
            }()

            guard result.itemProvider.canLoadObject(ofClass: UIImage.self) else { return }

            result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                DispatchQueue.main.async {
                    guard let image = object as? UIImage else { return }
                    self.onImagePicked(image, location)
                }
            }
        }
    }
}
