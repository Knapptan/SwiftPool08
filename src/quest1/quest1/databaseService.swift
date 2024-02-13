//
//  databaseService.swift
//  quest1
//
//  Created by Knapptan on 05.02.2024.
//

import Foundation

protocol DatabaseService {
    func saveData(_ :[User]) -> Void
    var SavedUsers: [User] {get set}
}

class ReleaseDatabaseServiceImpl: DatabaseService{
    var SavedUsers: [User] = []
    func saveData (_ users: [User]) -> Void {
        SavedUsers = users
        print("Release: \(SavedUsers) were saved")
    }
}

class DebugDatabaseServiceImpl: DatabaseService{
    var SavedUsers: [User] = []
    func saveData (_ users: [User]) -> Void {
        SavedUsers = users
        print("Debug: \(SavedUsers) were saved")
    }
}
