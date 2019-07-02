//
//  AppRouter.swift
//  something
//
//  Created by Maxim Semenov on 30/06/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import UIKit

class AppRouter: AppRouterProtocol {
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func route2Search() {
        window.rootViewController = UINavigationController(rootViewController: SearchAssembly.makeModule())
        window.makeKeyAndVisible()
    }
    
    private let window: UIWindow
}
