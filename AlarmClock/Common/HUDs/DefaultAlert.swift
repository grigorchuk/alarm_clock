//
//  DefaultAlert.swift
// AlarmClock
//

import UIKit

final class DefaultAlert: Alert {
    
    func show(
        on controller: UIViewController,
        title: String? = nil,
        message: String? = nil,
        style: UIAlertController.Style = .alert,
        actions: [UIAlertAction] = []
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        if actions.isEmpty {
            let action = UIAlertAction(title: L10n.Alert.Ok.button, style: .cancel, handler: nil)
            alert.addAction(action)
        } else {
            actions.forEach(alert.addAction)
        }
        
        controller.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(with error: Error, on controller: UIViewController) {
        show(on: controller, title: error.localizedDescription)
    }
}
