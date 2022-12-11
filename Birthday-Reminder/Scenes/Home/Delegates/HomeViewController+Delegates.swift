//
//  HomeViewController+Delegates.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 08/12/2022.
//

import Foundation

protocol ReminderCreatedDelegates: AnyObject {
    func createdReminder(_ reminder: Reminder!)
}
