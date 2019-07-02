//
//  ThrottleInvoker.swift
//  something
//
//  Created by Maxim Semenov on 01/07/2019.
//  Copyright © 2019 Maxim Semenov. All rights reserved.
//

import Foundation

class ThrottleInvoker {
    
    func throttle(duration: TimeInterval, block: @escaping () -> ()) {
        job.cancel()
        
        job = DispatchWorkItem(){ [weak self] in
            self?.previousRun = Date()
            block()
        }
        queue.asyncAfter(deadline: .now() + duration, execute: job)
    }
    
    private var job: DispatchWorkItem = DispatchWorkItem(block: {})
    private var previousRun: Date = Date.distantPast
    
    private let queue: DispatchQueue = DispatchQueue.global(qos: .background)
}
