//
//  AppSettingsManager.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 10/12/2022.
//

import UIKit
import Photos
import Contacts

final class AppSettingsManager {
    
    // MARK: - Static Properties
    
    static let shared = AppSettingsManager()
    
    // MARK: - Properties

    private let userDefaults = UserDefaults.standard
    
    // MARK: - Contacts Properties
    
    private var contactsStore: CNContactStore! {
        let baseContactStore = CNContactStore.init()
        return baseContactStore
    }
    
    private(set) var contactsPermmissionIsGranted: Bool! = false
    
    // MARK: - Photo Library Properties
    
    private(set) var photoLibraryPermissionisGranted: Bool! = false

    
    // MARK: - Calander Properties
    
    private let calendar = Calendar.current


    private init() {}
    
    private struct SettingsKeys {
        static let nightModeKey = "NightMode"
    }
    
    var nightMode: nightModeOptions {
        get {
            let rawValue = userDefaults.integer(forKey: SettingsKeys.nightModeKey)
            return nightModeOptions(rawValue: rawValue)!
        } set {
            userDefaults.set(newValue.rawValue, forKey: SettingsKeys.nightModeKey)
        }
    }
    
    func setNightModeObserver(target: NSObject!) {
        userDefaults.addObserver(target, forKeyPath: SettingsKeys.nightModeKey, options: [.new], context: nil)
    }
    
    func removeNightModObserver(target: NSObject!) {
        userDefaults.removeObserver(target, forKeyPath: SettingsKeys.nightModeKey)
    }
    
}

extension AppSettingsManager {

    // MARK: - Contacts Permission Requset

    func contactsRequestAccess() {
        let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
        switch(authorizationStatus) {
            case .authorized:
                self.contactsPermmissionIsGranted = true
            case .notDetermined:
                self.contactsStore.requestAccess(for: .contacts) { isGranted, isError in
                    guard let _ = isError else {
                        self.contactsPermmissionIsGranted = isGranted
                        return
                    }
                    self.contactsPermmissionIsGranted = false
                }
            default:
                self.contactsPermmissionIsGranted = false
        }
    }

}

extension AppSettingsManager {
    
    // MARK: - Photo Library Persmission Request
    
    func photoLibraryRequestAccess() {
        var authorizationStatus: PHAuthorizationStatus!
        if #available(iOS 14, *) {
            authorizationStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        } else {
            authorizationStatus = PHPhotoLibrary.authorizationStatus()
        }
        switch(authorizationStatus) {
            case .authorized:
                self.photoLibraryPermissionisGranted = true
            case .notDetermined:
                if #available(iOS 14, *) {
                    PHPhotoLibrary.requestAuthorization(for: .readWrite) { isGranted in
                        self.photoLibraryPermissionisGranted = (isGranted == .authorized)
                    }
                } else {
                    PHPhotoLibrary.requestAuthorization { isGranted in
                        self.photoLibraryPermissionisGranted = (isGranted == .authorized)
                    }
                }
            default:
                self.photoLibraryPermissionisGranted = false
        }
    }
    
}

extension AppSettingsManager {
    
    // MARK: - Calander Helper
    
    func getNextBirthdayDate(_ birthdayDate: Date!) -> Date! {
        let currentDate = self.calendar.startOfDay(for: Date())
        let birthdayDate = self.calendar.startOfDay(for: birthdayDate)
        let daysAndMonthsUntilNextBirthday = self.calendar.dateComponents([.day, .month], from: birthdayDate)
        let nextBirthday = self.calendar.nextDate(after: currentDate, matching: daysAndMonthsUntilNextBirthday, matchingPolicy: .nextTimePreservingSmallerComponents)!
        return nextBirthday
    }
    
    func daysCountDown(_ birthdayDate: Date!) -> String {
        let currentDate = self.calendar.startOfDay(for: Date())
        let birthdayDate = self.calendar.startOfDay(for: birthdayDate)
        let nextBirthday = self.getNextBirthdayDate(birthdayDate)!
        let daysCountDown = self.calendar.dateComponents([.day], from: currentDate, to: nextBirthday)
        if(daysCountDown.day == 365) {
            return "Today"
        } else if (daysCountDown.day == 1) {
            return "1 Day"
        }
        return "\(daysCountDown.day!) Days"
    }
    
    func getAgeNextBirthday(_ nextBirthday: Date, _ birthdayDate: Date!) -> (Int, Int) {
        let birthdayDate = self.calendar.startOfDay(for: birthdayDate)
        let nextBirthday = self.calendar.startOfDay(for: nextBirthday)
        let birthdayDayOfMonth = self.calendar.dateComponents([.day], from: birthdayDate)
        let yearsOld = self.calendar.dateComponents([.year, .day], from: birthdayDate, to: nextBirthday)
        return (yearsOld.year!, birthdayDayOfMonth.day!)
    }
    
    func getTableViewConfigruation(birthdayDate: Date!) -> (String, String) {
        let nextBirthday = self.getNextBirthdayDate(birthdayDate)!
        let countDownDays = self.daysCountDown(birthdayDate)
        let (turnAge, atDay) = self.getAgeNextBirthday(nextBirthday, birthdayDate)
        if(turnAge == 1) {
            return ("Happy Birthday!", "Today!")
        }
        let TurnsAgeNextBirthday = "Turns \(turnAge) at \(atDay)"
        return (TurnsAgeNextBirthday, countDownDays)
    }
    
    
}
