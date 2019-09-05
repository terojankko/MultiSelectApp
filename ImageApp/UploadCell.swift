//
//  UploadCell.swift
//  ImageApp
//
//  Created by Tero Jankko on 9/3/19.
//  Copyright © 2019 Tero Jankko. All rights reserved.
//

import UIKit
import Photos

class UploadCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
