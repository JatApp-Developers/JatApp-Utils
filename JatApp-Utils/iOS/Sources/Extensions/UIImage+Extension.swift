//
//  UIImage+Extension.swift
//  JatApp-Utils-macOS
//
//  Created by Developer on 2/19/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import UIKit

public extension UIImage {
    
    func resized(to newSize: CGSize,
                 transform: CGAffineTransform,
                 transpose: Bool,
                 quality: CGInterpolationQuality) -> UIImage? {
        let rect = CGRect(origin: .zero, size: newSize)
        let rectIntegral = rect.integral
        let transposedRect = CGRect(x: 0, y: 0, width: rectIntegral.size.height, height: rectIntegral.size.width)
        
        guard let cgImage = cgImage else {
            return nil
        }
        
        guard let colorSpace = cgImage.colorSpace,
            let ctx = CGContext(data: nil,
                                width: Int(rect.size.width),
                                height: Int(rect.size.height),
                                bitsPerComponent: cgImage.bitsPerComponent,
                                bytesPerRow: 0,
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
                                    return nil
        }
        
        ctx.concatenate(transform)
        ctx.interpolationQuality = quality
        ctx.draw(cgImage, in: transpose ? transposedRect : rect)
        
        guard let newImageRef = ctx.makeImage() else {
            return nil
        }
        
        return UIImage(cgImage: newImageRef)
    }
    
    func resized(with size: CGSize, quality: CGInterpolationQuality) -> UIImage? {
        var drawTransposed = false
        
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            drawTransposed = true
        default:
            drawTransposed = false
        }
        
        return self.resized(to: size, transform: transformForOrientation(with: size), transpose: drawTransposed, quality: quality)
    }
    
    func transformForOrientation(with size: CGSize) -> CGAffineTransform {
        
        var rectTransform: CGAffineTransform
        switch imageOrientation {
        case .left, .leftMirrored:
            rectTransform = CGAffineTransform(rotationAngle: .pi / 2.0).translatedBy(x: 0, y: -size.height)
        case .right, .rightMirrored:
            rectTransform = CGAffineTransform(rotationAngle: -.pi / 2.0).translatedBy(x: -size.width, y: 0)
        case .down, .downMirrored:
            rectTransform = CGAffineTransform(rotationAngle: -.pi).translatedBy(x: -size.width, y: -size.height)
        default:
            rectTransform = .identity
        }
        
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            rectTransform.translatedBy(x: size.width, y: 0).scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            rectTransform.translatedBy(x: size.height, y: 0).scaledBy(x: -1, y: 1)
        case .up, .down, .left, .right:
            break
        @unknown default:
            break
        }
        
        return rectTransform
    }
    
    func proportionalResize(targetWidth: CGFloat) -> UIImage? {
        let scaleFactor = targetWidth / size.width
        let targetHeight = size.height * scaleFactor
        let targetSize = CGSize(width: targetWidth, height: targetHeight)
        
        let image = self.resized(with: targetSize, quality: .low)
        return image
    }
    
    func croppedInRect(rect: CGRect) -> UIImage? {
        
        let rectTransform = transformForOrientation(with: size).scaledBy(x: scale, y: scale)
        
        guard let imageRef = cgImage?.cropping(to: rect.applying(rectTransform)) else {
            return nil
        }
        
        return  UIImage(cgImage: imageRef, scale: scale, orientation: imageOrientation)
    }
}
