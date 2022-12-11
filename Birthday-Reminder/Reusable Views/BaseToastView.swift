//
//  BaseToastView.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 10/12/2022.
//

import UIKit

final class BaseToastView: UIView {

    private var toastLabel: UILabel = {
        let baseLabel = UILabel()
        baseLabel.textColor = .systemBrown
        baseLabel.textAlignment = .center
        baseLabel.font = .preferredFont(forTextStyle: .headline)
        baseLabel.disableAutoResizeinMask()
        return baseLabel
    }()
    
    init(_ toastMessage: String!) {
        super.init(frame: CGRect.zero)
        self.setupToastView(toastMessage)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupToastView(_ toastMessage: String!) {

        self.disableAutoResizeinMask()
        self.alpha = 0.00
        self.backgroundColor = .systemGray5.withAlphaComponent(0.75)
        self.toastLabel.text = toastMessage
        self.addSubview(self.toastLabel)
        let toastConstraints = [
            self.toastLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            self.toastLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            self.toastLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            self.toastLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(toastConstraints)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 8
    }
    
}

