//
//  ImageListViewController.swift
//  ImageApp
//
//  Created by Tero Jankko on 9/3/19.
//  Copyright © 2019 Tero Jankko. All rights reserved.
//

import UIKit
import Photos

class ImageListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var imageTable: UITableView!

    var assets: [PHAsset]?

    override func viewDidLoad() {
        super.viewDidLoad()
        imageTable.delegate = self
        imageTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let assets = assets else {
            return 0
        }
        return assets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let assets = assets else {
            fatalError()
        }
        let cell = imageTable.dequeueReusableCell(withIdentifier: "UploadCell") as! UploadCell
        let asset = assets[indexPath.row]
        cell.icon.image = asset.image
        cell.name.text = asset.name
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            assets?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
