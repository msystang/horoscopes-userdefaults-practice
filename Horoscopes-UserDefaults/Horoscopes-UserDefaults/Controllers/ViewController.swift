//
//  ViewController.swift
//  Horoscopes-UserDefaults
//
//  Created by Sunni Tang on 9/24/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var sunsignLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var horoscopeLabel: UILabel!
    
    //MARK: - Variables
    var horoscope: Horoscope?
    
    var user: User? {
        didSet {
            loadHoroscopeData()
        }
    }
    
    var name: String = "" {
        didSet {
            welcomeLabel.text = "Welcome " + self.name + "!"
        }
    }
    
    //MARK: - Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
        configureDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadHoroscopeData()
        if let storedName = UserDefaultsWrapper.manager.getName() {
            name = storedName
        }
        if let storedBirthday = UserDefaultsWrapper.manager.getBirthday() {
            datePicker.date = storedBirthday
        }
        if let storedSunsign = UserDefaultsWrapper.manager.getSunsign() {
            sunsignLabel.text = storedSunsign
        }
        if let storedHoroscope = UserDefaultsWrapper.manager.getHoroscope() {
            horoscopeLabel.text = storedHoroscope
        }
        
    }

    //MARK: - IB Actions
    @IBAction func buttonClickedSaveInfo(_ sender: UIButton) {
        user = User(name: name, birthday: datePicker.date)
        if let horoscope = horoscope {
            UserDefaultsWrapper.manager.store(name: user!.name)
            UserDefaultsWrapper.manager.store(birthday: datePicker.date)
            UserDefaultsWrapper.manager.store(sunsign: horoscope.sunsign)
            UserDefaultsWrapper.manager.store(horoscope: horoscope.horoscope)
        }
    }
    
    //MARK: - Private functions
    private func configureTextField() {
        nameTextField.delegate = self
    }
    
    private func configureDatePicker() {
        datePicker.datePickerMode = .date
    }
    
    private func loadHoroscopeData() {
        if let userSign = user?.sunsign {
            let urlStr = "http://sandipbgt.com/theastrologer/api/horoscope/\( userSign)/today/"

            HoroscopeAPIClient.manager.getHoroscopeFromURL(urlStr: urlStr ) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let horoscopeFromOnline):
                        self.horoscope = horoscopeFromOnline
                        self.sunsignLabel.text = self.horoscope?.sunsign
                        self.horoscopeLabel.text = self.horoscope?.horoscope
                    }
                }
            }
        }
    }

}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            name = updatedText
        }
        return true
    }
}
