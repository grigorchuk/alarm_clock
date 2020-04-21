//
//  MainFlowCoordinator.swift
// AlarmClock
//
//  Created by Aleksandr on 12.04.2020.
//  Copyright © 2020 Grigorchuk. All rights reserved.
//

import Core
import UIKit
import Swinject

final class MainFlowCoordinator: NavigationNode, Coordinator {
    
    weak var mainViewController: UIViewController?
    
    private let container: Container
    
    init(parentNode: NavigationNode, parentContainer: Container) {
        self.container = Container(parent: parentContainer) {
            MainFlowAssembly().assemble(container: $0)
        }
        
        super.init(parent: parentNode)
        
        observeEvents()
    }
    
    func createFlow() -> UIViewController {
        let model = AlarmClockModel(
            parent: self,
            alarmClockManager: container.autoresolve(),
            notificationService: container.autoresolve(),
            timerService: container.autoresolve()
        )
        let controller = AlarmClockViewController(model: model)
        mainViewController = controller
        
        return controller
    }
    
    private func observeEvents() {
        addHandler { [weak self] (event: AlarmClockEvent) in
            guard case .didRequestPicker(let callback) = event else { return }
            
            self?.presentPickerController(pickerCallback: callback)
        }
        
        addHandler { [weak self] (event: PickerModelEvent) in
            guard case .didRequestClosing = event else { return }
            
            self?.mainViewController?.presentedViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    private func presentPickerController(pickerCallback: @escaping PickDateCallback) {
        let model = PickerModel(parent: self, pickerCallback: pickerCallback)
        let controller = PickerViewController(model: model)
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
        
        mainViewController?.present(controller, animated: true, completion: nil)
    }
}
