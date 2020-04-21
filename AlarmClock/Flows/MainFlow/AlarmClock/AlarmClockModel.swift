//
//  AlarmClockModel.swift
// AlarmClock
//
//  Created by Aleksandr on 12.04.2020.
//  Copyright © 2020 Grigorchuk. All rights reserved.
//

import Core

enum AlarmClockEvent: NavigationEvent {
    
    case didRequestPicker(PickDateCallback)
}

typealias PickDateCallback = (Date?) -> Void

final class AlarmClockModel: NavigationNode {
    
    // MARK: - Properties
    
    var pickedDateCallback: (PickDateCallback)?
    
    var alarmClockDelegate: AlarmClockManagerDelegate? {
        get { alarmClockManager.delegate }
        set { alarmClockManager.delegate = newValue }
    }
    var notificationDelegate: NotificationServiceDelegate? {
        get { notificationService.delegate }
        set { notificationService.delegate = newValue }
    }
    var actionState: ActionState {
        return alarmClockManager.actionState
    }
    
    private(set) var sleepTimerStep = SleepTimerStep.defaultValue
    
    private var selectedDate: Date? {
        didSet {
            pickedDateCallback?(selectedDate)
        }
    }
    
    private let alarmClockManager: AlarmClockManager
    private let notificationService: NotificationService
    private let timerService: TimerService
    
    // MARK: - Init
    
    init(
        parent: NavigationNode,
        alarmClockManager: AlarmClockManager,
        notificationService: NotificationService,
        timerService: TimerService
    ) {
        self.alarmClockManager = alarmClockManager
        self.notificationService = notificationService
        self.timerService = timerService
        
        super.init(parent: parent)
        
        setupTimerService()
    }
    
    func requestPermissions() {
        alarmClockManager.requestRecordPermission()
        notificationService.requestPermission()
    }
    
    func update(actionState: ActionState, appState: AppState? = nil) {
        if sleepTimerStep == .off {
            sleepTimerStep = SleepTimerStep.defaultValue
            alarmClockManager.set(actionState: .start, appState: .recording)
        } else {
            alarmClockManager.set(actionState: actionState, appState: appState)
        }
        
        guard appState == .playing else { return }
        
        timerService.start(minutes: sleepTimerStep.rawValue)
    }
    
    func scheduleNotification(title: String = L10n.Alert.Alarm.title) {
        guard let scheduleDate = selectedDate else { return }
        
        let content = notificationService.content(title: title)
        let trigger = notificationService.trigger(on: scheduleDate)
        notificationService.schedule(content: content, trigger: trigger)
    }
    
    func requestPicker() {
        raise(event:
            AlarmClockEvent.didRequestPicker { [weak self] date in
                self?.selectedDate = date
            }
        )
    }
    
    func selectSleepTimeStep(_ step: SleepTimerStep) {
        sleepTimerStep = step
    }
    
    private func setupTimerService() {
        timerService.didEndCallback = { [weak alarmClockManager] in
            alarmClockManager?.set(actionState: .stop)
        }
    }
}
