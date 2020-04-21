//
//  AlertPresentable.swift
// AlarmClock
//

import UIKit

protocol AlertPresentable {
    
    associatedtype AlertType: Alert
    
    var alert: AlertType { get }
    
    func showAlert(
        on controller: UIViewController,
        title: String?,
        message: String?,
        style: UIAlertController.Style,
        actions: [UIAlertAction]
    )
    func showAlert(with error: Error, on controller: UIViewController)
    
}

extension AlertPresentable where Self: UIViewController {
    
    func showAlert(
        on controller: UIViewController,
        title: String?,
        message: String? = nil,
        style: UIAlertController.Style = .alert,
        actions: [UIAlertAction]
    ) {
        alert.show(on: self, title: title, message: message, style: style, actions: actions)
    }
    
    func showAlert(with error: Error, on controller: UIViewController) {
        alert.showAlert(with: error, on: controller)
    }
}
