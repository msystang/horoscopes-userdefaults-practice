//
//  ViewController.swift
//  Horoscopes-UserDefaults
//
//  Created by Sunni Tang on 9/24/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var horoscope: Horoscope? {
        didSet {
            sunsignLabel.text = horoscope?.sunsign
        }
    }
    
    
    @IBOutlet weak var sunsignLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadHoroscopeData()
    }

    private func loadHoroscopeData() {
        HoroscopeAPIClient.manager.getHoroscopeFromURL { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let horoscopeFromOnline):
                    self.horoscope = horoscopeFromOnline
                }
            }
        }
    }

}

