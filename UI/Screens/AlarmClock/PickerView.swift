//
//  PickerView.swift
//  UI
//
//  Created by Aleksandr on 13.04.2020.
//  Copyright © 2020 Grigorchuk. All rights reserved.
//

import UIKit

private let datePickerKeyTextColor = "textColor"

public final class PickerView: BaseView {
    
    // MARK: - Properties
    
    public var didSelectDate: ((Date) -> Void)?
    public var didSelectCancel: (() -> Void)?
    
    private let containerView = UIView()
    private let datePicker = UIDatePicker()
    
    // MARK: - Init
    
    public override init() {
        super.init()
        
        setupView()
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    // MARK: - Private
    
    private func setupView() {
        setupContainer()
        setupDatePicker()
        setupToolbar()
    }
    
    private func setupContainer() {
        containerView.backgroundColor = .white
        
        addSubview(containerView)
        containerView.layout {
            $0.leading.equal(to: leadingAnchor)
            $0.trailing.equal(to: trailingAnchor)
            $0.bottom.equal(to: bottomAnchor)
            $0.height.equal(to: 280.0)
        }
    }
    
    private func setupToolbar() {
        let doneItem = UIBarButtonItem(title: L10n.Toolbar.Done.button, style: .done, target: self, action: #selector(doneAction(_ :)))
        let cancelItem = UIBarButtonItem(title: L10n.Toolbar.Cancel.button, style: .plain, target: self, action: #selector(cancelAction(_ :)))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let title = UIBarButtonItem(title: L10n.Toolbar.Alarm.title, style: .done, target: nil, action: nil)
        title.tintColor = .black
        
        let screenWidth = UIScreen.main.bounds.width
        let frame = CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)
        let toolbar = UIToolbar(frame: frame)
        toolbar.items = [cancelItem, flexibleSpace, title, flexibleSpace, doneItem]
        toolbar.sizeToFit()
        
        containerView.addSubview(toolbar)
        toolbar.layout {
            $0.top.equal(to: containerView.topAnchor)
            $0.leading.equal(to: containerView.leadingAnchor)
            $0.trailing.equal(to: containerView.trailingAnchor)
            $0.bottom.equal(to: datePicker.topAnchor)
            $0.height.equal(to: frame.height)
        }
    }
    
    private func setupDatePicker() {
        datePicker.datePickerMode = .time
        datePicker.layer.borderWidth = 0.25
        datePicker.layer.borderColor = UIColor.black.cgColor
        datePicker.setValue(UIColor.black, forKeyPath: datePickerKeyTextColor)
        
        containerView.addSubview(datePicker)
        datePicker.layout {
            $0.leading.equal(to: containerView.leadingAnchor)
            $0.trailing.equal(to: containerView.trailingAnchor)
            $0.bottom.equal(to: containerView.bottomAnchor)
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func doneAction(_ sender: UIBarButtonItem) {
        didSelectDate?(datePicker.date)
    }
    
    @objc
    private func cancelAction(_ sender: UIBarButtonItem) {
        didSelectCancel?()
    }
}
