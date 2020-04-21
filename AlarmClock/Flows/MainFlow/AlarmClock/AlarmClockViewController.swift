//
//  AlarmClockViewController.swift
// AlarmClock
//
//  Created by Aleksandr on 12.04.2020.
//  Copyright © 2020 Grigorchuk. All rights reserved.
//

import UI
import Core
import UIKit

final class AlarmClockViewController: BaseViewController, AlertPresentable, HasCustomView {
    
    typealias CustomView = AlarmClockView
    
    // MARK: - Properties
    
    let alert = DefaultAlert()
    
    private let model: AlarmClockModel
    
    // MARK: - Init
    
    init(model: AlarmClockModel) {
        self.model = model
        
        super.init()
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        let customView = CustomView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupCallback()
        model.requestPermissions()
        model.alarmClockDelegate = self
        model.notificationDelegate = self
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        customView.selectSleepTimerButton.setTitle(model.sleepTimerStep.title, for: .normal)
        customView.actionButton.addTarget(self, action: #selector(action(_ :)), for: .touchUpInside)
        customView.selectSleepTimerButton.addTarget(self, action: #selector(selectSleepTime(_ :)), for: .touchUpInside)
        customView.selectAlarmButton.addTarget(self, action: #selector(selectAlarmTime(_ :)), for: .touchUpInside)
    }
    
    private func setupCallback() {
        model.pickedDateCallback = { [weak customView] date in
            guard let date = date else { return }
            
            let alarmDateString = DateFormatters.timeFormatter.string(for: date)
            customView?.selectAlarmButton.setTitle(alarmDateString, for: .normal)
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func action(_ sender: UIButton) {
        switch model.actionState {
        case .idle, .stop: model.scheduleNotification()
        case .start, .resume: model.update(actionState: .pause)
        case .pause: model.update(actionState: .resume)
        }
    }
    
    @objc
    private func selectSleepTime(_ sender: UIButton) {
        presentSelectSleepTimeAlert()
    }
    
    @objc
    private func selectAlarmTime(_ sender: UIButton) {
        model.requestPicker()
    }
    
    // MARK: - Alerts
    
    private func presentSelectSleepTimeAlert() {
        var actions: [UIAlertAction] = [UIAlertAction(title: L10n.Alert.Cancel.button, style: .cancel)]
        
        SleepTimerStep.allCases.forEach { [weak self] step in
            guard let self = self else { return }
            
            let action = UIAlertAction(title: step.title, style: .default) { _ in
                self.model.selectSleepTimeStep(step)
                self.customView.selectSleepTimerButton.setTitle(step.title, for: .normal)
            }
            actions.append(action)
        }
        
        // Breaking constraint - IOS 12.2+ bug
        showAlert(on: self, title: L10n.SleepTimer.title, style: .actionSheet, actions: actions)
    }
    
    private func presentAlarmAlert() {
        let stopAction = UIAlertAction(title: L10n.Alert.Stop.button, style: .cancel) { [weak self] _ in
            guard let self = self else { return }
            
            let sleepTimerStepTitle = self.model.sleepTimerStep.title
            self.customView.selectSleepTimerButton.setTitle(sleepTimerStepTitle, for: .normal)
            self.customView.apply(action: L10n.Button.Start.title)
            self.customView.setDefaultState()
            self.model.update(actionState: .stop, appState: .idle)
        }
        // Breaking constraint - IOS 12.2+ bug
        showAlert(on: self, title: L10n.Alert.Alarm.title, actions: [stopAction])
    }
}

extension AlarmClockViewController: AlarmClockManagerDelegate {
    
    func didChangeState(_ state: AppState) {
        customView.apply(state: state.title)
        
        switch state {
        case .playing, .recording: customView.apply(action: L10n.Button.Pause.title)
        case .idle, .alarm: customView.apply(action: L10n.Button.Start.title)
        case .paused: customView.apply(action: L10n.Button.Resume.title)
        }
    }
    
    func didReceiveAudioError(_ error: Error) {
        // Breaking constraint - IOS 12.2+ bug
        showAlert(with: error, on: self)
    }
}

extension AlarmClockViewController: NotificationServiceDelegate {
    
    func didScheduleNotification() {
        model.update(actionState: .start, appState: .playing)
    }
    
    func didReceiveNotification() {
        model.update(actionState: .start, appState: .alarm)
        presentAlarmAlert()
    }
    
    func didReceiveNotificationError(_ error: Error) {
        // Breaking constraint - IOS 12.2+ bug
        showAlert(with: error, on: self)
    }
}
