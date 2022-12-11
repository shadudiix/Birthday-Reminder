//
//  BaseLoadingView.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 10/12/2022.
//

import UIKit

final class BaseLoadingView: UIView {
    
    private var loadingIndicator: UIActivityIndicatorView = {
        let baseIndicator = UIActivityIndicatorView()
        baseIndicator.disableAutoResizeinMask()
        baseIndicator.style = .large
        baseIndicator.color = .systemBrown
        baseIndicator.startAnimating()
        return baseIndicator
    }()

    
    init() {
        super.init(frame: CGRect.zero)
        self.setupLoadingView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 8
    }
    
    private func setupLoadingView() {
        
        self.disableAutoResizeinMask()
        self.backgroundColor = .black.withAlphaComponent(0.75)
        
        self.addSubview(loadingIndicator)
        let loadingIndicatorConstriants = [
            loadingIndicator.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            loadingIndicator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            loadingIndicator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            loadingIndicator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
        ]
        NSLayoutConstraint.activate(loadingIndicatorConstriants)
        
    }
}
