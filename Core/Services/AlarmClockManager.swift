//
//  AlarmClockManager.swift
// AlarmClock
//
//  Created by Aleksandr on 13.04.2020.
//  Copyright © 2020 Grigorchuk. All rights reserved.
//

import Foundation

public protocol AlarmClockManagerDelegate: class {
    
    func didChangeState(_ state: AppState)
    func didReceiveAudioError(_ error: Error)
}

public final class AlarmClockManager {
    
    public weak var delegate: AlarmClockManagerDelegate?
    
    public private(set) var actionState: ActionState = .idle
    
    private let audioSessionService: AudioSessionService
    private let recordingService: RecordingService
    private let playingService: PlayingService
    
    private var applicationState: AppState = .idle {
        didSet {
            delegate?.didChangeState(applicationState)
        }
    }
    
    public init(
        audioSessionService: AudioSessionService,
        recordingService: RecordingService,
        playingService: PlayingService
    ) {
        self.audioSessionService = audioSessionService
        self.recordingService = recordingService
        self.playingService = playingService
    }
    
    // MARK: - Public
    
    public func requestRecordPermission() {
        audioSessionService.requestRecordPermission { [weak delegate] result in
            switch result {
            case .success:
                print("Record permission granted")
                
            case .failure(let error):
                delegate?.didReceiveAudioError(error)
            }
        }
    }
    
    public func set(actionState: ActionState, appState: AppState? = nil) {
        self.actionState = actionState
        self.applicationState = appState ?? self.applicationState
        
        switch actionState {
        case .start, .resume: start()
        case .pause: pause()
        case .idle, .stop: stop()
        }
    }
    
    // MARK: Private
    
    private func start() {
        if case .paused(let audioState) = applicationState {
            if audioState == .record {
                recordingService.start()
                applicationState = .recording
            } else {
                playingService.start()
                applicationState = .playing
            }
        } else if applicationState == .recording {
            startRecording()
        } else {
            startPlaying(state: applicationState)
        }
    }
    
    private func pause() {
        if applicationState == .playing {
            playingService.pause()
            applicationState = .paused(.play)
        } else if applicationState == .recording {
            recordingService.pause()
            applicationState = .paused(.record)
        }
    }
    
    private func stop() {
        if applicationState == .playing || applicationState == .paused(.play) {
            playingService.stop()
            startRecording()
        } else {
            playingService.stop()
            recordingService.stop()
        }
    }
    
    private func startPlaying(state: AppState) {
        guard let fileName = state.fileName,
            let fileURL = LocalDataService.url(for: fileName, type: Constants.mp3) else {
            return
        }
        
        actionState = .start
        playingService.start(with: fileURL) { [weak self] result in
            switch result {
            case .success:
                self?.applicationState = state
                
            case .failure(let error):
                self?.delegate?.didReceiveAudioError(error)
            }
        }
    }
    
    private func startRecording() {
        let fileName = DateFormatters.fullDateFormatter.string(from: Date())
        
        actionState = .start
        recordingService.start(with: fileName) { [weak self] result in
            switch result {
            case .success:
                self?.applicationState = .recording
                
            case .failure(let error):
                self?.delegate?.didReceiveAudioError(error)
            }
        }
    }
}

private extension AppState {
    
    var fileName: String? {
        switch self {
        case .playing: return Constants.soundsOfNatureFileName
        case .alarm: return Constants.soundOfAlarmFileName
        default: return nil
        }
    }
}
