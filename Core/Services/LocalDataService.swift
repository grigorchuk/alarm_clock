//
//  LocalDataService.swift
// AlarmClock
//
//  Created by Aleksandr on 12.04.2020.
//  Copyright © 2020 Grigorchuk. All rights reserved.
//

import Foundation

public final class LocalDataService {
    
    public static func url(for fileName: String, type: String) -> URL? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: type) else { return nil }
        
        return URL(fileURLWithPath: path)
    }
}
