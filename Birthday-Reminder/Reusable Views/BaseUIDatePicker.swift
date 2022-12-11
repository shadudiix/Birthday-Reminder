//
//  BaseUIDatePicker.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 08/12/2022.
//

import UIKit

@IBDesignable
final class BaseUIDatePicker: UIDatePicker {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupDatePicker()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupDatePicker()
    }
    
    private func setupDatePicker() {
        if(self.datePickerMode == .date) {
            if #available(iOS 15, *) {
                self.maximumDate = .now
            } else {
                self.maximumDate = .distantFuture
            }
        } else {
            self.date = .distantFuture
        }
    }
}
