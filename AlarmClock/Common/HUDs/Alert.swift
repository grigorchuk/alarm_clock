//
//  Alert.swift
// AlarmClock
//

import UIKit

protocol Alert {
    
    func show(
        on controller: UIViewController,
        title: String?,
        message: String?,
        style: UIAlertController.Style,
        actions: [UIAlertAction]
    )
    
    func showAlert(with error: Error, on controller: UIViewController)
}
