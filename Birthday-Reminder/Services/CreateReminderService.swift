//
//  CreateReminderService.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 08/12/2022.
//

import Foundation

final class CreateReminderService {
    
    private let sqliteManager: SQLiteManager<Reminder>! =
        .init(modelType: .reminder)
    
    // MARK: - Object Life Cycle
    
    deinit {
        print("deinit \(self)")
    }

    func create(_ model: Reminder!, handler: @escaping(Result<Reminder, Error>) -> ()) {
        self.sqliteManager.create(model, handler: handler)
    }
}
