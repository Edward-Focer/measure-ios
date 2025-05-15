//
//  CameraService.swift
//  measure
//
//  Created by Edward Focer on 14/05/25.
//

enum CameraPosition {
    case front
    case back
}

import AVFoundation
import UIKit

class CameraService: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var session = AVCaptureSession()
    @Published var photo: UIImage?

    private var output = AVCapturePhotoOutput()
    private var currentInput: AVCaptureDeviceInput?
    private var currentPosition: AVCaptureDevice.Position = .back
    private var previewLayer: AVCaptureVideoPreviewLayer?

    // MARK: - Start Session
    func startSession() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.session.beginConfiguration()

            guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: self.currentPosition),
                  let input = try? AVCaptureDeviceInput(device: device),
                  self.session.canAddInput(input),
                  self.session.canAddOutput(self.output)
            else {
                self.session.commitConfiguration()
                return
            }

            self.session.addInput(input)
            self.session.addOutput(self.output)
            self.currentInput = input

            self.session.commitConfiguration()
            self.session.startRunning()
        }
    }

    func stopSession() {
        DispatchQueue.global(qos: .userInitiated).async {
            if self.session.isRunning {
                self.session.stopRunning()
            }
        }
    }

    // MARK: - Switch Camera
    func switchCamera() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.session.beginConfiguration()

            // Remove current input
            if let currentInput = self.currentInput {
                self.session.removeInput(currentInput)
            }

            // Toggle camera
            let newPosition: AVCaptureDevice.Position = (self.currentPosition == .back) ? .front : .back

            guard let newDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: newPosition),
                  let newInput = try? AVCaptureDeviceInput(device: newDevice),
                  self.session.canAddInput(newInput)
            else {
                self.session.commitConfiguration()
                return
            }

            self.session.addInput(newInput)
            self.currentInput = newInput
            self.currentPosition = newPosition

            self.session.commitConfiguration()
        }
    }

    // MARK: - Capture
    func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        output.capturePhoto(with: settings, delegate: self)
    }

    // MARK: - Delegate
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation(),
              let image = UIImage(data: data) else { return }

        DispatchQueue.main.async {
            self.photo = image
        }
    }
}
