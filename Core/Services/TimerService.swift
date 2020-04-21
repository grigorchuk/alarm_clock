//
//  TimerService.swift
//  Core
//
//  Created by Aleksandr on 14.04.2020.
//  Copyright © 2020 Grigorchuk. All rights reserved.
//

import Foundation

public final class TimerService {
    
    // MARK: - Properties
    
    public var didEndCallback: (() -> Void)?
    
    private var timer: Timer?
    
    public init() {}
    
    // MARK: - Public
    
    public func start(minutes: Int) {
        timer = Timer.scheduledTimer(
            timeInterval: Double(minutes) * 60.0,
            target: self,
            selector: #selector(finish),
            userInfo: nil,
            repeats: false
        )
    }
    
    // MARK: - Private
    
    @objc
    private func finish() {
        timer?.invalidate()
        timer = nil
        
        didEndCallback?()
    }
}
