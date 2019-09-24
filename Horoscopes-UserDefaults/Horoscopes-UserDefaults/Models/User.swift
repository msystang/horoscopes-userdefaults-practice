//
//  User.swift
//  Horoscopes-UserDefaults
//
//  Created by Sunni Tang on 9/24/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation

struct User {
    let name: String
    let birthday: Date
    
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
                return "Capricorn"
            case 0120...0218 :
                return "Aquarius"
            case 0219...0320:
                return "Pisces"
            case 0321...0419:
                return "Aries"
            case 0420...0520:
                return "Taurus"
            case 0521...0620:
                return "Gemini"
            case 0621...0722:
                return "Cancer"
            case 0723...0822:
                return "Leo"
            case 0823...0922:
                return "Virgo"
            case 0923...1022:
                return "Libra"
            case 1023...1121:
                return "Scorpio"
            case 1122...1221:
                return "Sagittarius"
            case 1222...1231:
                return "Capricorn"
            default:
                return "No horoscope for this birthday!"
        }
    }
    

}
