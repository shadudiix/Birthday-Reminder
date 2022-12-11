//
//  BaseErrorCodes.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 08/12/2022.
//

import Foundation

enum BaseErrorCodes: LocalizedError {
    
    case unknownError
    case givenName
    case mobilerNumber
    case birthdayDate
    case notifyAt

    var errorDescription: String? {
        switch(self) {
            case .unknownError:
                return "an error occurred while processing your request."
            case .givenName:
                return "Name of person cannot be empty."
            case .mobilerNumber:
                return "Mobile number of person cannot be empty."
            case .birthdayDate:
                return "You must set reminder birthday."
            case .notifyAt:
                return "You must set reminder notification date."
        }
    }
}

