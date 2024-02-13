//
//  main.swift
//  quest1
//
//  Created by Knapptan on 05.02.2024.
//

import Foundation

class UserRepository: Equatable {
    static func == (lhs: UserRepository, rhs: UserRepository) -> Bool {
        return lhs.databaseService.SavedUsers == rhs.databaseService.SavedUsers
    }
    
    let networkService: NetworkService
    let databaseService: DatabaseService
    
    init(networkService: NetworkService, databaseService: DatabaseService) {
        self.networkService = networkService
        self.databaseService = databaseService
    }
    
    func updateUserData() {
        // Получаем данные о пользователях с помощью NetworkService
        let userData = networkService.getData()
        // Сохраняем полученные данные с помощью DatabaseService
        databaseService.saveData(userData)
    }
}
