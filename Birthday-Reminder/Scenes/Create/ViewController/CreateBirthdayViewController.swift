//
//  CreateBirthdayViewController.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 07/12/2022.
//

import UIKit
import ContactsUI
import SQLite


final class CreateBirthdayViewController: BaseUITableViewController {
    
    // MARK: - Properties
    
    private let createServices: CreateReminderService = .init()
    
    let reminderFactory: ReminderFactory = .init()
    
    private var appSettings: AppSettingsManager? {
        guard let sceneDelegates = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return nil
        }
        return sceneDelegates.appSettings
    }
    
    weak var parentCoordinator: HomeCoordinator?
    
    weak var delegates: ReminderCreatedDelegates?
    
    var birthdayTableView: CreateBirthdayTableView! {
        guard isViewLoaded else { return nil }
        return self.view as? CreateBirthdayTableView
    }
    
    private var createService: CreateReminderService! {
        let baseService = CreateReminderService()
        return baseService
    }
    
    // MARK: - Functions
    
    private func setupViewDependOnPermissions() {
        
        if let appSettings = self.appSettings {
            self.birthdayTableView.scopeButton.isEnabled = appSettings.contactsPermmissionIsGranted
        } else {
            self.birthdayTableView.scopeButton.isEnabled = false
        }
        
    }

    @objc private func personImageViewClicked(_ sender: UITapGestureRecognizer!) {
        self.parentCoordinator?.pushImagePickerViewController(delegates: self)
    }
    
    private func setupGesture() {
        
        let baseGesture = UITapGestureRecognizer(target: self, action: #selector(self.personImageViewClicked(_:)))
        self.birthdayTableView.personImageView.addGestureRecognizer(baseGesture)
    }
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewDependOnPermissions()
        self.setupGesture()
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    // MARK: - Object Life Cycle
    
    deinit {
        print("deinit \(self)")
    }
    
    // MARK: - Button Events
    
    @objc func doneButtonClicked(_ sender: UIBarButtonItem!) {
        do {
            self.reminderFactory.setGivenName(self.birthdayTableView.personNameTextField.text!)
            self.reminderFactory.setMobileNumber(self.birthdayTableView.mobileNumberTextField.text!)
            let reminderModel = try self.reminderFactory.build()
            self.showLoading()
            self.createService.create(reminderModel) { [weak self] createResult in
                guard let self = self else { return }
                self.hideLoading()
                switch(createResult) {
                    case .failure(let baseError):
                        self.parentCoordinator?.showAlert(baseError.localizedDescription)
                    case .success(let createdModel):
                        self.delegates?.createdReminder(createdModel)
                }
            }
        } catch {
            self.hideLoading()
            self.parentCoordinator?.showAlert(error.localizedDescription)
        }
    }
    
    @IBAction func scopeButtonClicked(_ sender: UIButton!) {
        self.parentCoordinator?.pushContactPickerViewController(delegates: self)
    }
    
    // MARK: - Date Picker Events
    
    @IBAction func setBirthdayDate(_ sender: UIDatePicker) {
        self.reminderFactory.setBirthdayDate(sender.date)
    }
    
}

extension CreateBirthdayViewController: CNContactPickerDelegate {
    
    // MARK: - Content Picker Delegates
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        let contactName = contact.givenName
        self.birthdayTableView.personNameTextField.text = contactName
        if let contactPhoneNumber = contact.phoneNumbers.first?.value.stringValue {
            self.birthdayTableView.mobileNumberTextField.text = contactPhoneNumber
        }
        if let contactBirthday = contact.birthday, let contactBirthdaytDate = contactBirthday.date {
            self.birthdayTableView.birthDatePicker.date = contactBirthdaytDate
        }
    }

}

extension CreateBirthdayViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    // MARK: - Image Picker Delegates
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        if let baseImagePath = (info[.imageURL] as? URL)?.lastPathComponent, let ImageData = (info[.originalImage] as! UIImage).jpegData(compressionQuality: 100) {
            do {
                let imagePath = (try picker.saveSelectedImageFromPicker(baseImagePath, imageData: ImageData))!
                self.reminderFactory.setImagePath(imagePath)
                self.birthdayTableView.personImageView.image = UIImage(contentsOfFile: imagePath)
            } catch {
                self.parentCoordinator?.showAlert(error.localizedDescription)
            }
        }
    }
}
