//
//  main.swift
//  quest2
//
//  Created by Knapptan on 05.02.2024.
//

import Foundation
import Swinject

// Получение объекта UserRepository с использованием фабричного метода:

// Создание контейнера
let container1 = Container()
// Регистрация NetworkService с реализацией NetworkServiceImpl
container1.register(NetworkService.self) { _ in NetworkServiceImpl() }
// Регистрация DatabaseService с реализацией ReleaseDatabaseServiceImpl
container1.register(DatabaseService.self) { _ in ReleaseDatabaseServiceImpl() }
// Регистрация UserRepository с зависимостями NetworkService и DatabaseService
container1.register(UserRepository.self) { resolver in
    let networkService = resolver.resolve(NetworkService.self)!
    let databaseService = resolver.resolve(DatabaseService.self)!
    return UserRepository(networkService: networkService, databaseService: databaseService)
}
// Получение объекта UserRepository из Container
guard let userRepository1 = container1.resolve(UserRepository.self) else {
    fatalError("\nFailed to resolve UserRepository from the container.\n")
}
// Вызов метода для обновления данных о пользователе для первого UserRepository
userRepository1.updateUserData()
// Получение еще одного объекта UserRepository из Container
guard let userRepository2 = container1.resolve(UserRepository.self) else {
    fatalError("\nFailed to resolve UserRepository from the container.\n")
}
// Сравнение двух полученных объектов UserRepository
if userRepository1 === userRepository2 {
    print("\nTwo UserRepository instances are the same.\n")
} else {
    print("\nTwo UserRepository instances are different.\n")
}

// Получение объекта UserRepository с использованием именнованных зависимостей:

let container2 = Container()
// Регистрация NetworkService с реализацией NetworkServiceImpl
container2.register(NetworkService.self) { _ in NetworkServiceImpl() }
// Регистрация DatabaseService с реализацией ReleaseDatabaseServiceImpl и именем "release"
container2.register(DatabaseService.self, name: "release") { _ in ReleaseDatabaseServiceImpl() }
// Регистрация DatabaseService с реализацией DebugDatabaseServiceImpl и именем "debug"
container2.register(DatabaseService.self, name: "debug") { _ in DebugDatabaseServiceImpl() }
// Регистрация UserRepository с зависимостями NetworkService и DatabaseService с именем "release"
container2.register(UserRepository.self, name: "release") { resolver in
    let networkService = resolver.resolve(NetworkService.self)!
    let databaseService = resolver.resolve(DatabaseService.self, name: "release")!
    return UserRepository(networkService: networkService, databaseService: databaseService)
}
// Регистрация UserRepository с зависимостями NetworkService и DatabaseService с именем "debug"
container2.register(UserRepository.self, name: "debug") { resolver in
    let networkService = resolver.resolve(NetworkService.self)!
    let databaseService = resolver.resolve(DatabaseService.self, name: "debug")!
    return UserRepository(networkService: networkService, databaseService: databaseService)
}
// Получение объекта UserRepository с именем "release" из контейнера
if let userRepositoryRelease = container2.resolve(UserRepository.self, name: "release") {
    // Вызов метода для обновления данных о пользователе
    userRepositoryRelease.updateUserData()
}
// Получение объекта UserRepository с именем "debug" из контейнера
if let userRepositoryDebug = container2.resolve(UserRepository.self, name: "debug") {
    // Вызов метода для обновления данных о пользователе
    userRepositoryDebug.updateUserData()
}

// Получение единственного экземпляра UserRepository:

// Создание контейнера
let container3 = Container()

// Регистрация NetworkService с реализацией NetworkServiceImpl
container3.register(NetworkService.self) { _ in NetworkServiceImpl() }

// Регистрация DatabaseService с реализацией ReleaseDatabaseServiceImpl
container3.register(DatabaseService.self) { _ in ReleaseDatabaseServiceImpl() }

// Регистрация UserRepository с зависимостями NetworkService и DatabaseService с использованием синглтона
container3.register(UserRepository.self) { resolver in
    let networkService = resolver.resolve(NetworkService.self)!
    let databaseService = resolver.resolve(DatabaseService.self)!
    return UserRepository(networkService: networkService, databaseService: databaseService)
}.inObjectScope(.container)

// Получение объекта UserRepository из контейнера
if let userRepository1 = container3.resolve(UserRepository.self) {
    // Вызов метода для обновления данных о пользователе
    userRepository1.updateUserData()
    
    // Получение еще одного объекта UserRepository из контейнера
    if let userRepository2 = container3.resolve(UserRepository.self) {
        // Сравнение двух объектов UserRepository
        if userRepository1 === userRepository2 {
            print("\nBoth UserRepositories are the same instance (singleton)\n")
        } else {
            print("\nUserRepositories are different instances\n")
        }
    }
}
