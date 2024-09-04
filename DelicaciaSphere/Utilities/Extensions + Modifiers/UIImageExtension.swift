//
//  UIImageExtension.swift
//  DelicaciaSphere
//
//  Created by Zohaib Ahmed on 9/4/24.
//

import SwiftUI
import CoreGraphics

extension UIImage {
    func croppedToContent() -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }
        let context = CGContext(
            data: nil,
            width: cgImage.width,
            height: cgImage.height,
            bitsPerComponent: cgImage.bitsPerComponent,
            bytesPerRow: cgImage.bytesPerRow,
            space: cgImage.colorSpace ?? CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: cgImage.bitmapInfo.rawValue
        )
        
        guard let context = context else { return nil }
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: cgImage.width, height: cgImage.height))
        guard let newCgImage = context.makeImage() else { return nil }
        
        let maskImage = newCgImage.masking(cgImage)
        return maskImage.flatMap { UIImage(cgImage: $0) }
    }
}

