//
//  UIImage+Crop.swift
//  CropViewController
//
//  Created by Guilherme Moura on 2/26/16.
//  Copyright © 2016 Reefactor, Inc. All rights reserved.
// Credit https://github.com/sprint84/PhotoCropEditor

import UIKit

extension UIImage {
    func rotatedImageWithTransform(_ rotation: CGAffineTransform, croppedToRect rect: CGRect) -> UIImage {
        let rotatedImage = rotatedImageWithTransform(rotation)
        
        let scale = rotatedImage.scale
        let cropRect = rect.applying(CGAffineTransform(scaleX: scale, y: scale))
        
        let croppedImage = rotatedImage.cgImage?.cropping(to: cropRect)
        let image = UIImage(cgImage: croppedImage!, scale: self.scale, orientation: rotatedImage.imageOrientation)
        return image
    }
    
    fileprivate func rotatedImageWithTransform(_ transform: CGAffineTransform) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, true, scale)
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: size.width / 2.0, y: size.height / 2.0)
        context?.concatenate(transform)
        context?.translateBy(x: size.width / -2.0, y: size.height / -2.0)
        draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rotatedImage!
    }

    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!

        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
