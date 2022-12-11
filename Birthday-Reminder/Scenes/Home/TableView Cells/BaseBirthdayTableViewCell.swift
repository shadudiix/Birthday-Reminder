//
//  BaseBirthdayTableViewCell.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 09/12/2022.
//

import UIKit

class BaseBirthdayTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var personImageView: BaseUIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var personBirthdayLabel: UILabel!
    @IBOutlet weak var personDaysCountDownLabel: UILabel!
    
    // MARK: - Overrided Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.personNameLabel.text = ""
        self.personBirthdayLabel.text = ""
        self.personImageView.image = UIImage.createBaseImage(.person)
    }
    
    func configure(
        _ personName: String!,
        _ turnsYears: String!,
        _ countDownDays: String!,
        _ imagePath: String?)
    {
        self.personNameLabel.text = personName
        self.personBirthdayLabel.text = turnsYears
        self.personDaysCountDownLabel.text = countDownDays
        guard let imagePath = imagePath else {
            return
        }
        self.personImageView.image = UIImage(contentsOfFile: imagePath)
    }
    
}

