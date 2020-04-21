//
//  ApplicationState.swift
// AlarmClock
//
//  Created by Aleksandr on 12.04.2020.
//  Copyright © 2020 Grigorchuk. All rights reserved.
//

public enum AppState: Equatable {
    
    case idle, playing, recording, paused(AudioState), alarm
}
