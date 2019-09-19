//
//  Photo.swift
//  ImageApp
//
//  Created by Tero Jankko on 9/5/19.
//  Copyright © 2019 Tero Jankko. All rights reserved.
//

import Foundation
import UIKit

enum MediaType {
    case photo
    case video
}

struct PhotoAttachment {
    var image: UIImage
    var name: String
    var uploadedBy: String
    var mediaType: MediaType
}
