//
//  AudioService.swift
// AlarmClock
//
//  Created by Aleksandr on 12.04.2020.
//  Copyright © 2020 Grigorchuk. All rights reserved.
//

import AVFoundation

private let defaultRecordSettings = [
    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
    AVSampleRateKey: 12000,
    AVNumberOfChannelsKey: 1,
    AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
]

public final class RecordingService {
    
    // MARK: - Properties
    
    private let audioSessionService: AudioSessionService
    
    private var audioRecorder: AVAudioRecorder!
    
    // MARK: - Init
    
    public init(audioSessionService: AudioSessionService) {
        self.audioSessionService = audioSessionService
    }
    
    // MARK: - Public
    
    public func start(
        with fileName: String,
        path: String = Constants.m4a,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        let url = documentDirectoryURL()
            .appendingPathComponent(fileName)
            .appendingPathExtension(path)
        
        audioSessionService.setupAudioSession(category: .playAndRecord) { [weak self] result in
            switch result {
            case .success:
                self?.tryToRecord(with: url, completion: completion)
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func start() {
        audioRecorder?.record()
    }
    
    public func pause() {
        audioRecorder?.pause()
    }
        
    public func stop() {
        audioRecorder?.stop()
        audioRecorder = nil
    }
    
    // MARK: - Private
    
    private func tryToRecord(
        with url: URL,
        settings: [String: Int] = defaultRecordSettings,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        do {
            audioRecorder = try AVAudioRecorder(url: url, settings: settings)
            start()
            
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    private func documentDirectoryURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
}
