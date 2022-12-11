//
//  Reminder.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 08/12/2022.
//

import Foundation

class Reminder: Codable, Identifiable {
    
    let uuid: String!
    let imagePath: String?
    let givenName: String!
    let mobileNumber: String!
    let birthdayDate: Date!
    init(uuid: String!, imagePath: String? = nil, givenName: String!, mobileNumber: String!, birthdayDate: Date!) {
        self.uuid = uuid
        self.imagePath = imagePath
        self.givenName = givenName
        self.mobileNumber = mobileNumber
        self.birthdayDate = birthdayDate
    }
}
