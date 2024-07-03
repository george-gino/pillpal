//
//  CameraView.swift
//  PillPal
//
//  Created by George Gino on 5/30/24.
//

import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    var onImagePicked: (UIImage) -> Void

    func makeUIViewController(context: Context) -> CameraViewController {
        let cameraViewController = CameraViewController()
        cameraViewController.onImagePicked = onImagePicked
        return cameraViewController
    }

    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {}
}

