//
//  PickerModel.swift
// AlarmClock
//
//  Created by Aleksandr on 13.04.2020.
//  Copyright © 2020 Grigorchuk. All rights reserved.
//

import Foundation

enum PickerModelEvent: NavigationEvent {
    
    case didRequestClosing
}

final class PickerModel: NavigationNode {
    
    // MARK: - Properties
    
    private let pickerCallback: PickDateCallback
    
    // MARK: - Init
    
    init(parent: NavigationNode, pickerCallback: @escaping PickDateCallback) {
        self.pickerCallback = pickerCallback
        
        super.init(parent: parent)
    }
    
    func selectDate(_ date: Date) {
        pickerCallback(date)
        requestClosing()
    }
    
    func requestClosing() {
        raise(event: PickerModelEvent.didRequestClosing)
    }
}
