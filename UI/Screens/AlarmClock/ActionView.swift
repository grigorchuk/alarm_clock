//
//  ActionView.swift
//  UI
//
//  Created by Aleksandr on 14.04.2020.
//  Copyright © 2020 Grigorchuk. All rights reserved.
//

import UIKit

public final class ActionView: BaseView {
    
    public var didSelect: (() -> Void)?
    
    public let titleLabel = UILabel()
    public let button = UIButton()
    
    public override init() {
        super.init()
        
        setupView()
        backgroundColor = .white
    }
    
    private func setupView() {
        setupTitleLabel()
        setupButton()
    }
    
    private func setupTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 16.0)
        titleLabel.textAlignment = .left
        titleLabel.textColor = .black
        
        addSubview(titleLabel)
        titleLabel.layout {
            $0.top.equal(to: topAnchor)
            $0.leading.equal(to: leadingAnchor)
            $0.bottom.equal(to: bottomAnchor)
        }
    }
    
    private func setupButton() {
        button.setTitle(L10n.Choose.button, for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        button.contentHorizontalAlignment = .right
        
        addSubview(button)
        button.layout {
            $0.top.equal(to: topAnchor)
            $0.leading.equal(to: titleLabel.trailingAnchor)
            $0.trailing.equal(to: trailingAnchor)
            $0.bottom.equal(to: bottomAnchor)
            $0.width.equal(to: titleLabel.widthAnchor)
        }
    }
}
