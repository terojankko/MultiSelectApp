//
//  UsesSpinner.swift
//  ImageApp
//
//  Created by Tero Jankko on 9/18/19.
//  Copyright © 2019 Tero Jankko. All rights reserved.
//

import Foundation
import UIKit

protocol UsesSpinner where Self: UIViewController {
    func showSpinner() -> SpinnerViewController
    func hideSpinner(_ spinner: SpinnerViewController)
}

extension UsesSpinner {
    func showSpinner() -> SpinnerViewController {
        let spinner = SpinnerViewController()
        self.addChild(spinner)
        spinner.view.frame = self.view.frame
        self.view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
        return spinner
    }
    func hideSpinner(_ spinner: SpinnerViewController) {
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }
}

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .whiteLarge)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
