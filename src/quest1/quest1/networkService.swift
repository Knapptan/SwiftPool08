//
//  networkService.swift
//  quest1
//
//  Created by Knapptan on 05.02.2024.
//

import Foundation

protocol NetworkService {
    func getData() -> [User]
}

class NetworkServiceImpl:NetworkService {
    func getData() -> [User]{
        return [
            User("Oleg1", "Olegov1", "Oleja1"),
            User("Oleg2", "Olegov2", "Oleja2"),
            User("Oleg3", "Olegov3", "Oleja3"),
            User("Oleg4", "Olegov4", "Oleja4")
        ]
    }
}
