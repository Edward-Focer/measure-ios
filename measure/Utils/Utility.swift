//
//  Utility.swift
//  measure
//
//  Created by Edward Focer on 16/05/25.
//

import UIKit

class Utility {
    // Shared static instance
    static let shared = Utility()
    
    // Private initializer to prevent external instantiation
    private init() {
        // Initialization code here
    }
    
    // Save UIImage to File
    func saveImageToDocuments(image: UIImage, fileName: String) -> URL? {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
        
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documents.appendingPathComponent(fileName)
        
        do {
            try data.write(to: fileURL)
            return fileURL
        } catch {
            print("Error saving image: \(error)")
            return nil
        }
    }
    
    // Load UIImage from URL
    func loadImageFromDocuments(path: String) -> UIImage? {
        let url = URL(fileURLWithPath: path)
        if let data = try? Data(contentsOf: url) {
            return UIImage(data: data)
        }
        return nil
    }
}
