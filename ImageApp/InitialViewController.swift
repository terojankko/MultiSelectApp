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

    fileprivate var photos = [Photo]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showPicker(_ sender: Any) {
        let vc = BSImagePickerViewController()

        vc.albumButton.tintColor = UIColor.green
        vc.cancelButton.tintColor = UIColor.red
        vc.doneButton.tintColor = UIColor.purple
        //vc.selectionCharacter = "✓"
        //vc.selectionFillColor = UIColor.gray
        vc.selectionStrokeColor = UIColor.yellow
        vc.selectionShadowColor = UIColor.red
        //vc.selectionTextAttributes[NSAttributedString.Key.foregroundColor] = UIColor.lightGray

        vc.cellsPerRow = {(verticalSize: UIUserInterfaceSizeClass, horizontalSize: UIUserInterfaceSizeClass) -> Int in
            switch (verticalSize, horizontalSize) {
            case (.compact, .regular): // iPhone portrait
                return 2
            case (.compact, .compact): // iPhone landscape
                return 2
            case (.regular, .regular): // iPad portrait/landscape
                return 3
            default:
                return 2
            }
        }

        bs_presentImagePickerController(vc, animated: true,
                                        select: { (asset: PHAsset) -> Void in
                                            self.photos.append(Photo(image: asset.image, name: asset.localIdentifier, uploadedBy: ""))
        }, deselect: { (asset: PHAsset) -> Void in
            self.photos = self.photos.filter { $0.name != asset.localIdentifier }
        }, cancel: { (assets: [PHAsset]) -> Void in
            print("--> cancelled")
        }, finish: { (assets: [PHAsset]) -> Void in
            //self.photos = photos
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditViewListController") as? EditViewListController {
                vc.photos = self.photos
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }, completion: nil)
    }


     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let editViewController = segue.destination as? EditViewListController {
            editViewController.photos = photos
        }
     }

}
