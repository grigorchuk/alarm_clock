//
//  PlayingService.swift
// AlarmClock
//
//  Created by Aleksandr on 12.04.2020.
//  Copyright © 2020 Grigorchuk. All rights reserved.
//

import AVFoundation

public final class PlayingService {
    
    // MARK: - Properties
    
    private let audioSessionService: AudioSessionService
    
    private var audioPlayer: AVAudioPlayer!
    
    // MARK: - Init
    
    public init(audioSessionService: AudioSessionService) {
        self.audioSessionService = audioSessionService
    }
    
    // MARK: - Public
    
    public func start(with url: URL, completion: @escaping (Result<Void, Error>) -> Void) {
        audioSessionService.setupAudioSession(category: .playback) { [weak self] result in
            switch result {
            case .success:
                self?.tryToPlay(with: url, completion: completion)
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func start() {
        audioPlayer?.prepareToPlay()
        audioPlayer?.play()
    }
    
    public func pause() {
        audioPlayer?.pause()
    }
    
    public func stop() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
    
    // MARK: - Private
    
    private func tryToPlay(with url: URL, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
            start()
            
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}
