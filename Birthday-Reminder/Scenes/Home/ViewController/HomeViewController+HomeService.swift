//
//  HomeViewController+HomeService.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 10/12/2022.
//

import UIKit

extension HomeViewController {
        
    func loadReminders() {
        self.showLoading()
        self.homeServices.getReminders { [weak self] fetchResult in
            guard let self = self else { return }
            self.hideLoading()
            switch(fetchResult) {
                case .success(let reminders):
                    self.reminders.append(contentsOf: reminders)
                    self.reloadTableView()
                case .failure(let baseError):
                    self.coordinator?.showAlert(baseError.localizedDescription)
            }
        }
    }
    
}
