//
//  EditViewListController.swift
//  ImageApp
//
//  Created by Tero Jankko on 9/3/19.
//  Copyright © 2019 Tero Jankko. All rights reserved.
//

import UIKit
import Photos
import iOSPhotoEditor

class EditViewListController: UIViewController, UITableViewDataSource, UITableViewDelegate, PhotoEditorDelegate {

    @IBOutlet weak var imageTable: UITableView!

    var photos: [Photo]?
    var start = 0.0
    
    override func viewDidLoad() {
        print("--> did load ", Date().timeIntervalSince1970 - start)
        super.viewDidLoad()
        imageTable.delegate = self
        imageTable.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        print("--> will appear ", Date().timeIntervalSince1970 - start)
    }

    override func viewDidAppear(_ animated: Bool) {
        print("--> did appear ", Date().timeIntervalSince1970 - start)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let photos = photos else {
            fatalError()
        }
        return photos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let photos = photos else {
            fatalError()
        }
        let cell = imageTable.dequeueReusableCell(withIdentifier: "EditListCell") as! EditListCell
        let photo = photos[indexPath.row]
        cell.icon.image = photo.image
        cell.name.text = photo.name
        cell.uploadedBy.text = photo.name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let photo = photos?[indexPath.row] else {
            fatalError()
        }
        let photoEditor = PhotoEditorViewController(nibName:"PhotoEditorViewController",bundle: Bundle(for: PhotoEditorViewController.self))
        photoEditor.photoEditorDelegate = self
        photoEditor.image = photo.image
        photoEditor.colors = [.red,.blue,.green]
        photoEditor.hiddenControls = [.text, .sticker]

        present(photoEditor, animated: true, completion: nil)
    }

    func doneEditing(image: UIImage) {
        print("--> done editing called with image")
        // save image
    }

    func canceledEditing() {
        print("--> canceled editing")
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let uploadViewController = segue.destination as? UploadViewController {
            uploadViewController.photos = photos
        }
    }


}
