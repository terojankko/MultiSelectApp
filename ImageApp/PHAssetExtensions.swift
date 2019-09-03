//
//  PHAssetExtensions.swift
//  ImageApp
//
//  Created by Tero Jankko on 9/3/19.
//  Copyright © 2019 Tero Jankko. All rights reserved.
//

import Foundation
import Photos

extension PHAsset {
    var image: UIImage {
        get {
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            var image = UIImage()
            option.isSynchronous = true
            manager.requestImage(for: self, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: option, resultHandler: {(result, info) -> Void in
                image = result!
            })
            return image
        }
    }

    var name: String {
        get {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            let date = self.creationDate
            return formatter.string(from:date!)
        }
    }
}
