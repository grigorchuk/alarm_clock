//
//  AudioSessionService.swift
// AlarmClock
//
//  Created by Aleksandr on 12.04.2020.
//  Copyright © 2020 Grigorchuk. All rights reserved.
//

import AVFoundation

public final class AudioSessionService {
    
    enum CustomError: Error {
        case recordPermissonDenied
    }
    
    // MARK: - Properties
    
    private let audioSession = AVAudioSession.sharedInstance()
    
    // MARK: - Init
    
    public init() {}
    
    // MARK: - Public
    
    public func requestRecordPermission(completion: @escaping (Result<Void, Error>) -> Void) {
        audioSession.requestRecordPermission { allowed in
            DispatchQueue.main.async {
                if allowed {
                    completion(.success(()))
                } else {
                    completion(.failure(CustomError.recordPermissonDenied))
                }
            }
        }
    }
    
    public func setupAudioSession(
        category: AVAudioSession.Category,
        mode: AVAudioSession.Mode = .default,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        do {
            try audioSession.setCategory(category, mode: mode)
            try audioSession.setActive(true)
            
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}
