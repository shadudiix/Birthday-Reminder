//
//  ReminderFactory.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 09/12/2022.
//

import Foundation

final class ReminderFactory {
    
    private var uuid: String! {
        return UUID().uuidString
    }
    
    private var imagePath: String?
    func setImagePath(_ imagePath: String!) {
        self.imagePath = imagePath
    }
    
    private var givenName: String?
    
    private var mobileNumber: String?
    
    private var birthdayDate: Date?
    
    func setGivenName(_ personName: String!) {
        self.givenName = personName
    }
    
    func setMobileNumber(_ personMobileNumber: String!) {
        self.mobileNumber = personMobileNumber
    }
    
    func setBirthdayDate(_ personBirthdayDate: Date!) {
        self.birthdayDate = personBirthdayDate
    }
    
    func build() throws -> Reminder {
        guard let givenName = self.givenName, givenName.count > 0 else {
            throw BaseErrorCodes.givenName
        }
        guard let mobileNumber = self.mobileNumber, mobileNumber.count > 0 else {
            throw BaseErrorCodes.mobilerNumber
        }
        guard let birthdayDate = self.birthdayDate else {
            throw BaseErrorCodes.birthdayDate
        }
        return Reminder.init(
            uuid: self.uuid, imagePath: imagePath, givenName: givenName,
            mobileNumber: "tel://\(mobileNumber)", birthdayDate: birthdayDate
        )
    }
    
    
    
}
