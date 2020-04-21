//
//  NotificationService.swift
// AlarmClock
//
//  Created by Aleksandr on 13.04.2020.
//  Copyright © 2020 Grigorchuk. All rights reserved.
//

import UserNotifications

public protocol NotificationServiceDelegate: class {
    
    func didScheduleNotification()
    func didReceiveNotification()
    func didReceiveNotificationError(_ error: Error)
}

public final class NotificationService: NSObject {
    
    enum CustomError: Error {
        case permissonDenied
    }
    
    public weak var delegate: NotificationServiceDelegate?
    
    private let center = UNUserNotificationCenter.current()
    
    public override init() {
        super.init()
        
        center.delegate = self
    }
    
    public func requestPermission() {
        center.requestAuthorization(options: [.alert]) { [weak delegate] granted, error in
            if granted {
                print("Notification permission granted")
            } else {
                delegate?.didReceiveNotificationError(error ?? CustomError.permissonDenied)
            }
        }
    }
    
    public func schedule(
        identifier: String = Constants.scheduleIdentifier,
        content: UNMutableNotificationContent,
        trigger: UNCalendarNotificationTrigger
    ) {
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        center.add(request) { [weak delegate] error in
            DispatchQueue.main.async {
                if let error = error {
                    delegate?.didReceiveNotificationError(error)
                } else {
                    delegate?.didScheduleNotification()
                }
            }
        }
    }
    
    public func content(
        title: String,
        categoryIdentifier: String = Constants.categoryIdentifier
    ) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.categoryIdentifier = categoryIdentifier
        
        return content
    }
    
    public func trigger(on date: Date) -> UNCalendarNotificationTrigger {
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
        return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    }
}

extension NotificationService: UNUserNotificationCenterDelegate {
    
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        delegate?.didReceiveNotification()
        
        completionHandler()
    }
    
    public func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        delegate?.didReceiveNotification()
        
        completionHandler(.sound)
    }
}
