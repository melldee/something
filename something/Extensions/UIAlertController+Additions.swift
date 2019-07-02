//
//  UIAlertController+Additions.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func okAlertController(with title: String = "", message: String, onTapOk: (() -> Void)? = nil) -> UIAlertController {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default, handler: { action in
            onTapOk?()
        })
        alertViewController.addAction(okAction)
        
        return alertViewController
    }
}
