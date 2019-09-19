//
//  EditListCell.swift
//  ImageApp
//
//  Created by Tero Jankko on 9/3/19.
//  Copyright © 2019 Tero Jankko. All rights reserved.
//

import UIKit

class EditListCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var uploadedBy: UITextField!
    @IBOutlet weak var editButton: UIButton!

    var photoAttachment: PhotoAttachment?
    var delegate: PhotoUpdater?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func editTapped(_ sender: Any) {
        guard let photoAttachment = photoAttachment else {
            return
        }
        delegate?.editImage(photoAttachment)
    }
    
}
