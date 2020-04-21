//
//  SleepTimerStep.swift
//  Core
//
//  Created by Aleksandr on 14.04.2020.
//  Copyright © 2020 Grigorchuk. All rights reserved.
//

import Foundation

public enum SleepTimerStep: Int, CaseIterable {
    
    case off, one, five = 5, ten = 10, fifteen = 15, twenty = 20
    
    public static var defaultValue: SleepTimerStep {
        return .five
    }
}
