//
//  UserDefaultsWrapper.swift
//  Horoscopes-UserDefaults
//
//  Created by Sunni Tang on 9/24/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation

class UserDefaultsWrapper {
    
    // MARK: - Static Properties
    static let manager = UserDefaultsWrapper()
    
    // MARK: - Internal getter methods
    func getName() -> String? {
        return UserDefaults.standard.value(forKey: nameKey) as? String
    }
    
    func getBirthday() -> Date? {
        return UserDefaults.standard.value(forKey: birthdayKey) as? Date
    }
    
    func getSunsign() -> String? {
        return UserDefaults.standard.value(forKey: sunsignKey) as? String
    }
    
    func getHoroscope() -> String? {
        return UserDefaults.standard.value(forKey: horoscopeKey) as? String
    }
    
    
    // MARK: - Internal setter methods
    func store(name: String) {
        UserDefaults.standard.set(name, forKey: nameKey)
    }
    
    func store(birthday: Date) {
        UserDefaults.standard.set(birthday, forKey: birthdayKey)
    }
    
    func store(sunsign: String) {
        UserDefaults.standard.set(sunsign, forKey: sunsignKey)
    }
    
    func store(horoscope: String) {
        UserDefaults.standard.set(horoscope, forKey: horoscopeKey)
    }
        
    // MARK: - Private Properties
    private let nameKey = "name"
    private let birthdayKey = "birthday"
    private let sunsignKey = "sunsignKey"
    private let horoscopeKey = "horoscopeKey"
    
    // MARK: - Private inits
    private init() {}
}
