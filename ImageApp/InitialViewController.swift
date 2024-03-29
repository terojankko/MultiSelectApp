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

class InitialViewController: UIViewController, UsesSpinner {

    //fileprivate var photos = [Photo]()
    var spinner: SpinnerViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        if traitCollection.userInterfaceStyle == .light {
            print("--> Light mode")
        } else {
            print("--> Dark mode")
        }
    }

    var start = 0.0

    var photos = [PhotoAttachment]()
    let dispatchGroup = DispatchGroup()
    let child = SpinnerViewController()

    @IBAction func showPicker(_ sender: Any) {
        let vc = BSImagePickerViewController()

        vc.albumButton.tintColor = UIColor.green
        vc.cancelButton.tintColor = UIColor.red
        vc.doneButton.tintColor = UIColor.purple
        //vc.selectionCharacter = "✓"
        //vc.selectionFillColor = UIColor.gray
        vc.selectionStrokeColor = UIColor.yellow
        vc.selectionShadowColor = UIColor.red

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
                                            self.dispatchGroup.enter()
                                            DispatchQueue.global(qos: .default).async {
                                                self.photos.append(PhotoAttachment(image: asset.image, name: asset.localIdentifier, uploadedBy: "Tero", mediaType: asset.mediaType == .video ? MediaType.video : MediaType.photo ))
                                                self.dispatchGroup.leave()
                                            }
        }, deselect: { (asset: PHAsset) -> Void in
            self.photos = self.photos.filter { $0.name != asset.localIdentifier }
        }, cancel: { (assets: [PHAsset]) -> Void in
            print("--> cancelled")
        }, finish: { [unowned self] (assets: [PHAsset]) -> Void in
            self.start = Date().timeIntervalSince1970
            print("--> alku")

            self.spinner = self.showSpinner()

            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditViewListController") as? EditViewListController {
                print("--> ennen copying photos ", Date().timeIntervalSince1970 - self.start)
                vc.photos = self.photos
                vc.start = self.start
                self.dispatchGroup.wait()
                print("--> ennen push ", Date().timeIntervalSince1970 - self.start)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            }, completion: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        print("--> did disappear ", Date().timeIntervalSince1970 - start)
        guard let spinner = spinner else {
            return
        }
        self.hideSpinner(spinner)
        self.spinner = nil
    }

    override func viewWillDisappear(_ animated: Bool) {
        print("--> will disappear ", Date().timeIntervalSince1970 - start)
    }
}
