//
//  PickerViewController.swift
// AlarmClock
//
//  Created by Aleksandr on 13.04.2020.
//  Copyright © 2020 Grigorchuk. All rights reserved.
//

import UI
import Core
import UIKit

final class PickerViewController: BaseViewController, HasCustomView {
    
    typealias CustomView = PickerView
    
    // MARK: - Properties
    
    private let model: PickerModel
    
    // MARK: - Init
    
    init(model: PickerModel) {
        self.model = model
        
        super.init()
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        let customView = CustomView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCallback()
    }
    
    // MARK: - Setup views
    
    private func setupCallback() {
        customView.didSelectDate = { [weak model] date in
            model?.selectDate(date)
        }
        
        customView.didSelectCancel = { [weak model] in
            model?.requestClosing()
        }
    }
}
