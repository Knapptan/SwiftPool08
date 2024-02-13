//
//  user.swift
//  quest1
//
//  Created by Knapptan on 05.02.2024.
//

import Foundation

class User: Equatable {
    let Id: UUID
    let Name: String
    let FirstName: String
    let Nickname: String
    
    init (_ name: String,_ firstName: String,_ nickname: String){
        self.Id = UUID()
        self.Name = name
        self.FirstName = firstName
        self.Nickname = nickname
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.Id == rhs.Id
    }
}
