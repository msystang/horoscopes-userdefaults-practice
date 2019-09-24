//
//  HoroscopeAPIClient.swift
//  Horoscopes-UserDefaults
//
//  Created by Sunni Tang on 9/24/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import Foundation

struct HoroscopeAPIClient {
    
    // MARK: -- Static Properties
    static let manager = HoroscopeAPIClient()
    
    // MARK: -- Internal Methods
    func getHoroscopeFromURL(completionHandler: @escaping (Result<Horoscope, AppError>) -> () ) {

        guard let urlfromStr = URL(string: horoscopeUrlStr) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        NetworkHelper.manager.performDataTask(withUrl: urlfromStr, andMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
                return
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(Horoscope.self, from: data)
                    completionHandler(.success(response))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
    
    // MARK: -- Private Properties and Initializers
    
    private let horoscopeUrlStr = "http://sandipbgt.com/theastrologer/api/horoscope/virgo/today/"
    
    private init() {}
}
