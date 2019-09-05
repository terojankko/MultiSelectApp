//
//  ImageListViewController.swift
//  ImageApp
//
//  Created by Tero Jankko on 9/3/19.
//  Copyright © 2019 Tero Jankko. All rights reserved.
//

import UIKit
import Photos

class UploadViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var imageTable: UITableView!
    
    var assets: [PHAsset]?
    var fileSizes: [Int]?
    let startDate = Date()
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        imageTable.delegate = self
        imageTable.dataSource = self
        guard let assets = assets else {
            return
        }
        fileSizes = [Int]()
        for _ in 0..<assets.count {
            fileSizes!.append(Int.random(in: 3..<8))
        }
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
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
        cell.index = indexPath.row
        return cell
    }


    @objc func update() {
        let secondsPassed = Date().timeIntervalSince(startDate)
        for cell in imageTable.visibleCells  {
            let fileSize = fileSizes![(cell as! UploadCell).index!]
            var progress = secondsPassed / Double(fileSize)
            if progress >= 100.0 {
                progress = 100.0
            }
            (cell as! UploadCell).progressBar.progress = Float(progress)
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            assets?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
