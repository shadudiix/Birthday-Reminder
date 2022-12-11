//
//  CreateBirthdayTableView.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 08/12/2022.
//

import UIKit

final class CreateBirthdayTableView: BaseUITableView {
    
    // MARK: - UI Components
    
    @IBOutlet weak var personImageView: UIImageView!
    
    @IBOutlet weak var personNameTextField: UITextField!
    
    @IBOutlet weak var mobileNumberTextField: UITextField!
    
    @IBOutlet weak var birthDatePicker: BaseUIDatePicker!
    
    @IBOutlet weak var scopeButton: UIButton!
    
    @IBOutlet weak var notifyAtDatePicker: BaseUIDatePicker!
    
}
