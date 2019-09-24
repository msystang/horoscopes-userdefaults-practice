//
//  User.swift
//  Horoscopes-UserDefaults
//
//  Created by Sunni Tang on 9/24/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation

struct User {
    
    // MARK: -- Static Properties
    let name: String
    let birthday: Date
    
    // MARK: -- Computed Properties
    var birthMonthDate: Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMdd"
        let strDate = dateFormatter.string(from: birthday)
        if let intDate = Int(strDate) {
            return intDate
        }
        return 0
    }
    
    var sunsign: String {
        switch birthMonthDate {
            case 0101...0119:
                return "capricorn"
            case 0120...0218 :
                return "aquarius"
            case 0219...0320:
                return "pisces"
            case 0321...0419:
                return "aries"
            case 0420...0520:
                return "taurus"
            case 0521...0620:
                return "gemini"
            case 0621...0722:
                return "cancer"
            case 0723...0822:
                return "leo"
            case 0823...0922:
                return "virgo"
            case 0923...1022:
                return "libra"
            case 1023...1121:
                return "scorpio"
            case 1122...1221:
                return "sagittarius"
            case 1222...1231:
                return "capricorn"
            default:
                return "No horoscope for this birthday!"
        }
    }

}
