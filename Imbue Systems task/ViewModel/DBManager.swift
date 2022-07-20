//
//  DBManager.swift
//  Imbue Systems task
//
//  Created by Kostya Tsyvilko on 18.07.22.
//

import Foundation
import SQLite3

/// Defining error states in DBManager
enum SQLiteError: Error {
    case Prepare(message: String)
    case DatabaseNotOpened(message: String)
}

/// Class for managing working with database of payments
class DBManager: ObservableObject {
    @Published var paymentsInfo = [PaymentModel]()
    private var db: OpaquePointer?
    
    // Singleton to have one instance of a class
    static var manager = DBManager()
    
    /// Opening database with data of payments
    private init() {
        // Finding db file in Build files
        let dbPath = Bundle.main.path(forResource: "payments", ofType: "sqlite")
        sqlite3_open(dbPath, &db)
    }
    
    deinit {
        if db != nil {
            sqlite3_close(db)
        }
    }
    
    /// Reads database to getting data
    func getDBData() throws {
        var queryStatement: OpaquePointer?
        
        let selectAllQuery = "SELECT * FROM Payment"
        
        guard db != nil else { throw SQLiteError.DatabaseNotOpened(message: "Database wouldn't be opened") }
        
        if sqlite3_prepare_v2(db, selectAllQuery, -1, &queryStatement, nil) != SQLITE_OK {
            if let errorMsg = sqlite3_errmsg(db) {
                let message = String(cString: errorMsg)
                throw SQLiteError.Prepare(message: message)
            }
            else {
                throw SQLiteError.Prepare(message: "Error in preparing")
            }
        }
        
        // Going through all rows
        while (sqlite3_step(queryStatement) == SQLITE_ROW) {
            // Getting data from database
            let id = sqlite3_column_int(queryStatement, 0)
            let name = sqlite3_column_text(queryStatement, 1)!
            let tmpEmail = sqlite3_column_text(queryStatement, 2) // Optional
            let tmpPhoneNumber = sqlite3_column_text(queryStatement, 3) // Optional
            let amountOfPayment = sqlite3_column_double(queryStatement, 4)
            let strDate = sqlite3_column_text(queryStatement, 5)!
            let status = sqlite3_column_int(queryStatement, 6)
            
            // MARK: converting data
            let date = PaymentModel.convertStringToDate(strDate: String(cString: strDate))
            let email = tmpEmail != nil ? String(cString: tmpEmail!) : nil
            let phoneNumber = tmpPhoneNumber != nil ? String(cString: tmpPhoneNumber!) : nil
            
            let payment = PaymentModel(
                id: id,
                name: String(cString: name),
                email: email,
                phoneNumber: phoneNumber,
                amountOfPayment: amountOfPayment,
                date: date,
                status: Status(rawValue: Int(status))!
            )
            
            paymentsInfo.append(payment)
            
        }
        
        // Sorting items by date
        paymentsInfo.sort {
            $0.date > $1.date
        }
        
        
    }
}
