//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Andres Rojas on 22/11/19.
//  Copyright © 2019 Andres Rojas. All rights reserved.
//

import UIKit

class BaseViewController<View: UIView>: UIViewController {

    // MARK: - Properties

    var customView: View {
        return view as! View
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(recognizer:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    override func loadView() {
        view = View(frame: UIScreen.main.bounds)
    }

}

