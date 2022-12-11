//
//  SearchUITextField.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 09/12/2022.
//

import UIKit

@IBDesignable
final class SearchUITextField: UITextField {
    
    private var padding: UIEdgeInsets {
        return .init(top: 10, left: 40, bottom: 10, right: 35)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func borderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let clearButtonRect = super.clearButtonRect(forBounds: bounds)
        return clearButtonRect.offsetBy(dx: -10, dy: 0)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let leftViewRect = super.leftViewRect(forBounds: bounds)
        return leftViewRect.offsetBy(dx: 10, dy: 0)
    }
    
    init() {
        super.init(frame: CGRect.zero)
        self.setupTextField()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupTextField()
    }
    
    private func setupTextField() {
        
        self.disableAutoResizeinMask()
        self.borderStyle = .none
        self.backgroundColor = .systemGray5
        self.clearButtonMode = .always
        self.leftView = UIImageView(image: .createBaseImage(.search, color: .systemGray))
        self.leftViewMode = .always
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 8
    }
    
}

