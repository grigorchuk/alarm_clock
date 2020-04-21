//
//  SleepTimerStep+Localization.swift
// AlarmClock
//
//  Created by Aleksandr on 14.04.2020.
//  Copyright © 2020 Grigorchuk. All rights reserved.
//

import Core

extension SleepTimerStep {
    
    var title: String {
        switch self {
        case .off: return L10n.SleepTimer.off
        case .one: return L10n.SleepTimer.one
        case .five: return L10n.SleepTimer.five
        case .ten: return L10n.SleepTimer.ten
        case .fifteen: return L10n.SleepTimer.fifteen
        case .twenty: return L10n.SleepTimer.twenty
        }
    }
}
