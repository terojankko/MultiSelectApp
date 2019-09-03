//
//  InitialViewController.swift
//  ImageApp
//
//  Created by Tero Jankko on 9/3/19.
//  Copyright © 2019 Tero Jankko. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos

class InitialViewController: UIViewController {

    fileprivate var imageAssets = [PHAsset]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func showPicker(_ sender: Any) {
        let vc = BSImagePickerViewController()

        bs_presentImagePickerController(vc, animated: true,
                                        select: { (asset: PHAsset) -> Void in
                                            self.imageAssets.append(asset)
                                            print("--> added ", asset.name)
        }, deselect: { (asset: PHAsset) -> Void in
            self.imageAssets = self.imageAssets.filter { $0.localIdentifier != asset.localIdentifier }
        }, cancel: { (assets: [PHAsset]) -> Void in
            print("--> cancelled")
        }, finish: { (assets: [PHAsset]) -> Void in
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageListViewController") as? ImageListViewController {
                vc.assets = assets
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }, completion: nil)
    }

}
