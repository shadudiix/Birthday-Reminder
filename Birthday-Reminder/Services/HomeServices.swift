//
//  HomeServices.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 10/12/2022.
//

import Foundation
import SQLite

final class HomeServices {
    
    private let sqliteManager: SQLiteManager<Reminder>! =
        .init(modelType: .reminder)

    // MARK: - Object Life Cycle
    
    deinit {
        print("deinit \(self)")
    }
    
    func getReminders(_ handler: @escaping(Swift.Result<[Reminder], Error>) -> ()) {
        // map here
        self.sqliteManager.read(handler: handler)
    }
    
    func delete(row: Reminder!, handler: @escaping(Swift.Result<Bool, Error>) -> ()) {
        self.sqliteManager.delete(Expression<String>("uuid") == row.uuid, handler: handler) 
    }
    
}

