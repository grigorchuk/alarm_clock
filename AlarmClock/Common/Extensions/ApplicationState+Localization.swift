//
//  ApplicationState+Localization.swift
// AlarmClock
//
//  Created by Aleksandr on 13.04.2020.
//  Copyright © 2020 Grigorchuk. All rights reserved.
//

import Core

extension AppState {
    
    var title: String {
        switch self {
        case .idle: return L10n.ApplicationState.idle
        case .playing: return L10n.ApplicationState.playing
        case .recording: return L10n.ApplicationState.recording
        case .paused: return L10n.ApplicationState.paused
        case .alarm: return L10n.ApplicationState.alarm
        }
    }
}
