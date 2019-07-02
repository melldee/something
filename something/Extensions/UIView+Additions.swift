//
//  UIView+Additions.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import UIKit

extension UIView {
    func addSameSizeConstraintSubview(_ subview: UIView) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([leftAnchor.constraint(equalTo: subview.leftAnchor),
                                     rightAnchor.constraint(equalTo: subview.rightAnchor),
                                     topAnchor.constraint(equalTo: subview.topAnchor),
                                     bottomAnchor.constraint(equalTo: subview.bottomAnchor)])
    }
}
