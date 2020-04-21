//
//  ApplicationFlowCoordinator.swift
// AlarmClock
//
//  Created by Aleksandr on 11.04.2020.
//  Copyright © 2020 Grigorchuk. All rights reserved.
//

import UIKit
import Swinject

final class ApplicationFlowCoordinator: NavigationNode {
    
    private let window: UIWindow
    private let container: Container
    
    init(window: UIWindow) {
        self.window = window
        self.container = Container {
            ApplicationFlowAssembly().assemble(container: $0)
        }
        
        super.init(parent: nil)
    }
    
    func execute() {
        presentMainFlow()
    }
    
    private func presentMainFlow() {
        let coordinator = buildMainFlow()
        setRootViewController(coordinator.createFlow())
    }
    
    private func buildMainFlow() -> Coordinator {
        return MainFlowCoordinator(parentNode: self, parentContainer: container)
    }
    
    private func setRootViewController(_ controller: UIViewController) {
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
}
