//
//  SQLiteManager.swift
//  Birthday-Reminder
//
//  Created by Shady K. Maadawy on 08/12/2022.
//

import Foundation
import SQLite

final class SQLiteManager<T: Codable> {
    
    // MARK: - Concurrency Properties
    
    private var sqliteQueue: DispatchQueue! {
        return DispatchQueue(label: "...", qos: .userInitiated, attributes: .concurrent)
    }
    // MARK: - Configuration
    
    typealias T = T
    
    enum ModelsTypes: Int {
        case reminder = 0
    }
    
    // MARK: - Properties

    private var databaseConnection: Connection! {
        do {
            guard let coreDatabasePath = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true).first else {
                fatalError("Cannot query document directory")
            }
            let baseConnection = try Connection("\(coreDatabasePath)/core.sqlite3")
            return baseConnection
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    private let sqliteTable: Table!
    
    // MARK: - Initialization
    
    init(modelType: ModelsTypes!) {
        do {
            let tableIdentifier = String(describing: T.self)
            self.sqliteTable = .init(tableIdentifier)
            try self.configurateTable(modelType)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK: - Object Life Cycle
    
    deinit {
        print("deinit \(self)")
    }
    
    // MARK: - Functions
    
    private func configurateTable(_ modelType: ModelsTypes!) throws {
        switch(modelType) {
            case .reminder:
                try self.databaseConnection.run(self.sqliteTable.create(temporary: false, ifNotExists: true, block: { tableBlockBuilder in
                    tableBlockBuilder.column(Expression<String>("uuid"), primaryKey: true)
                    tableBlockBuilder.column(Expression<String?>("imagePath"))
                    tableBlockBuilder.column(Expression<String>("givenName"))
                    tableBlockBuilder.column(Expression<String>("mobileNumber"))
                    tableBlockBuilder.column(Expression<Date>("birthdayDate"))
                }))
        default:
            fatalError("Unknown model type")
        }
    }
    
    // MARK: ~ C R U D
    
    func create(_ row: T, handler: @escaping(Swift.Result<T, Error>) -> ()) {
        self.sqliteQueue.async { 
            do {
                try self.databaseConnection.run(self.sqliteTable.insert(row))
                DispatchQueue.main.async {
                    handler(.success(row))
                }
            } catch {
                DispatchQueue.main.async {
                    handler(.failure(error))
                }
            }
        }
    }
    
    func read(handler: @escaping(Swift.Result<[T], Error>) -> ()) {
        self.sqliteQueue.async {
            do {
                let mappedRows: [T]! = try self.databaseConnection.prepare(self.sqliteTable).map { sqliteRow in
                    return try sqliteRow.decode()
                }
                DispatchQueue.main.async {
                    handler(.success(mappedRows))
                }
            } catch {
                DispatchQueue.main.async {
                    handler(.failure(error))
                }
            }
        }
    }
    
    func delete(_ predicate: Expression<Bool>, handler: @escaping(Swift.Result<Bool, Error>) -> ()) {
        self.sqliteQueue.async {
            do {
                let efectedRows = try self.databaseConnection.run(self.sqliteTable.filter(predicate).delete())
                DispatchQueue.main.async {
                    handler(.success(efectedRows > 0))
                }
            } catch {
                DispatchQueue.main.async {
                    handler(.failure(error))
                }
            }
        }
    }
}
