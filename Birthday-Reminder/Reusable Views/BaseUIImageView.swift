//
//  BaseUIImageView.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 08/12/2022.
//

import UIKit

@IBDesignable
final class BaseUIImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupImageView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupImageView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 12
    }
    
    private func setupImageView() {
        self.backgroundColor = .systemGray5
    }
}
