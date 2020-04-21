//
//  AlarmClockView.swift
//  UI
//
//  Created by Aleksandr on 12.04.2020.
//  Copyright © 2020 Grigorchuk. All rights reserved.
//

import UIKit

public final class AlarmClockView: BaseView {
    
    public var selectSleepTimerButton: UIButton {
        return sleepTimerActionView.button
    }
    public var selectAlarmButton: UIButton {
        return alarmActionView.button
    }
    
    public let titleStateLabel = UILabel()
    public let actionButton = UIButton()
    
    private let sleepTimerActionView = ActionView()
    private let alarmActionView = ActionView()
    private let stackView = UIStackView()
    
    public override init() {
        super.init()
        
        setupView()
        backgroundColor = .white
    }
    
    public func apply(state: String) {
        titleStateLabel.text = state
    }
    
    public func apply(action: String) {
        actionButton.setTitle(action, for: .normal)
    }
    
    public func setDefaultState() {
        alarmActionView.button.setTitle(L10n.Choose.button, for: .normal)
    }
    
    private func setupView() {
        setupTitleLabel()
        setupActionButton()
        setupStackView()
        setupActions()
    }
    
    private func setupTitleLabel() {
        titleStateLabel.text = L10n.ApplicationState.idle
        titleStateLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        titleStateLabel.textAlignment = .center
        titleStateLabel.textColor = .black
        
        addSubview(titleStateLabel)
        titleStateLabel.layout {
            $0.top.equal(to: safeAreaLayoutGuide.topAnchor, offsetBy: 48.0)
            $0.centerX.equal(to: centerXAnchor)
        }
    }
    
    private func setupActionButton() {
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.backgroundColor = .blue
        actionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        actionButton.setTitle(L10n.Button.Start.title, for: .normal)
        actionButton.layer.cornerRadius = 16.0
        
        addSubview(actionButton)
        actionButton.layout {
            $0.centerX.equal(to: centerXAnchor)
            $0.leading.equal(to: leadingAnchor, offsetBy: 24.0)
            $0.trailing.equal(to: trailingAnchor, offsetBy: -24.0)
            $0.bottom.equal(to: bottomAnchor, offsetBy: -48.0)
            $0.height.equal(to: 64.0)
        }
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 4.0
        stackView.distribution = .fill
        
        addSubview(stackView)
        stackView.layout {
            $0.leading.equal(to: leadingAnchor, offsetBy: 24.0)
            $0.trailing.equal(to: trailingAnchor, offsetBy: -24.0)
            $0.bottom.equal(to: actionButton.topAnchor, offsetBy: -64.0)
        }
        
        stackView.addArrangedSubview(separatorView())
        stackView.addArrangedSubview(sleepTimerActionView)
        stackView.addArrangedSubview(separatorView())
        stackView.addArrangedSubview(alarmActionView)
        stackView.addArrangedSubview(separatorView())
    }
    
    private func setupActions() {
        sleepTimerActionView.titleLabel.text = L10n.SleepTimer.title
        sleepTimerActionView.layout { $0.height.equal(to: 44.0) }
        
        alarmActionView.titleLabel.text = L10n.Alarm.title
        alarmActionView.layout { $0.height.equal(to: 44.0) }
    }
    
    private func separatorView() -> UIView {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layout { $0.height.equal(to: 0.35) }
        
        return view
    }
}
