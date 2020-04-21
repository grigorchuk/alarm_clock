//
//  MainFlowAssembly.swift
// AlarmClock
//
//  Created by Aleksandr on 12.04.2020.
//  Copyright © 2020 Grigorchuk. All rights reserved.
//

import Core
import Swinject

final class MainFlowAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(AlarmClockManager.self) { resolver in
            AlarmClockManager(
                audioSessionService: resolver.autoresolve(),
                recordingService: resolver.autoresolve(),
                playingService: resolver.autoresolve()
            )
        }.inObjectScope(.container)
        
        container.register(TimerService.self) { _ in
            TimerService()
        }.inObjectScope(.transient)
    }
}
