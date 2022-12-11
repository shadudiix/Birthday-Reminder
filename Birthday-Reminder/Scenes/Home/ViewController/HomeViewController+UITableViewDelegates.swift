//
//  HomeViewController+UITableViewDelegates.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 08/12/2022.
//

import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    var homeView: HomeView! {
        guard self.isViewLoaded else { return nil }
        return view as? HomeView
    }
    
    func setupTableView() {
        self.homeView.birthdaysTableView.registerNibCell(BaseBirthdayTableViewCell.self)
    }
    
    func insertNewRowToTableView() {
        self.homeView.birthdaysTableView.insertRows(
            at: [IndexPath.init(row: self.reminders.count - 1, section: 0)],
            with: .automatic
        )
    }
    
    func removeCellFromTableView(_ indexPath: IndexPath) {
        self.homeView.birthdaysTableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func reloadTableView() {
        self.homeView.birthdaysTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tableView = tableView as? BaseUITableView else { return self.reminders.count }
        if(self.reminders.count == 0) {
            tableView.showEmptyMessageLabel()
        } else {
            tableView.hideEmptyMessageLabel()
        }
        return self.reminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let baseTableViewCell = tableView.dequeueCell() as BaseBirthdayTableViewCell
        let personModel = self.reminders[indexPath.row]
        let (turnsYears, countDownDays) = self.appSettings?.getTableViewConfigruation(birthdayDate: personModel.birthdayDate) ?? ("Unknown", "Unknown")
        baseTableViewCell.configure(
            personModel.givenName,
            turnsYears,
            countDownDays,
            personModel.imagePath
        )
        return baseTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        tableView.deselectRow(at: indexPath, animated: true)
        let reminder = self.reminders[indexPath.row]
        self.coordinator?.pushCallActionSheet({ [weak self] actionSheetResult in
            guard let self = self else { return }
            if(actionSheetResult) {
                self.callPhoneByNumber(reminder, handler: nil)
            }
        })
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextAction = UIContextualAction(style: .destructive, title: "Delete", handler: { [weak self] _, _, deleteRequest in
            guard let self = self else { return }
            self.coordinator?.showAlert("If you continiue, this action cannot be cancled") { alertResult in
                if(alertResult) {
                    let personReminder = self.reminders[indexPath.row]
                    self.homeServices.delete(row: personReminder) { [weak self] deleteResult in
                        guard let self = self else { return }
                        switch(deleteResult) {
                            case .success(let isDeleted):
                            if(isDeleted) {
                                self.reminders.remove(at: indexPath.row)
                                self.removeCellFromTableView(indexPath)
                                deleteRequest(true)
                            } else {
                                deleteRequest(false)
                                self.coordinator?.showAlert("Cannot delete yor reminder")
                            }
                            case .failure(let baseErorr):
                                deleteRequest(false)
                                self.coordinator?.showAlert(baseErorr.localizedDescription)
                        }
                    }
                } else {
                    deleteRequest(false)
                }
            }
        })
        contextAction.backgroundColor = .systemRed
        contextAction.image = UIImage.createBaseImage(.trash, color: .white)
        return UISwipeActionsConfiguration(actions: [contextAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextAciton = UIContextualAction(style: .normal, title: "Call") { [weak self] _, _, callRequest in
            guard let self = self else { return }
            let reminder = self.reminders[indexPath.row]
            self.callPhoneByNumber(reminder) { _callResult in
                callRequest(_callResult)
            }
        }
        contextAciton.backgroundColor = .systemBrown
        contextAciton.image = UIImage.createBaseImage(.call, color: .white)
        return UISwipeActionsConfiguration(actions: [contextAciton])
    }
}
