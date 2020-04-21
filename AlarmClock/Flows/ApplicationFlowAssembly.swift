//
//  ApplicationFlowAssembly.swift
// AlarmClock
//
//  Created by Aleksandr on 11.04.2020.
//  Copyright © 2020 Grigorchuk. All rights reserved.
//

import Core
import Swinject

final class ApplicationFlowAssembly: Assembly {

    func assemble(container: Container) {
        container.register(AudioSessionService.self) { _ in
            AudioSessionService()
        }.inObjectScope(.container)
        
        container.register(RecordingService.self) { resolver in
            RecordingService(audioSessionService: resolver.autoresolve())
        }.inObjectScope(.container)
        
        container.register(PlayingService.self) { resolver in
            PlayingService(audioSessionService: resolver.autoresolve())
        }.inObjectScope(.container)
        
        container.register(NotificationService.self) { _ in
            NotificationService()
        }.inObjectScope(.container)
    }
}
