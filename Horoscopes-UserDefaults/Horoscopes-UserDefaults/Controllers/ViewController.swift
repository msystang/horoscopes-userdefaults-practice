//
//  ViewController.swift
//  Horoscopes-UserDefaults
//
//  Created by Sunni Tang on 9/24/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var sunsignLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var horoscopeLabel: UILabel!
    
    var user: User? {
        didSet {
            loadHoroscopeData()
        }
    }
    
    var horoscope: Horoscope?
    
    var name: String = "" {
        didSet {
            welcomeLabel.text = "Welcome " + self.name + "!"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        configureDatePicker()
        
        if let storedName = UserDefaults.standard.value(forKey: "name") as? String {
            name = storedName
        }
        if let storedBirthday = UserDefaults.standard.value(forKey: "birthday") as? Date {
            datePicker.date = storedBirthday
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadHoroscopeData()
        
    }


    @IBAction func buttonClickedSaveInfo(_ sender: UIButton) {
        user = User(name: name, birthday: datePicker.date)
        UserDefaults.standard.set(user?.name, forKey: "name")
        UserDefaults.standard.set(user?.birthday, forKey: "birthday")
    }
    
    
    private func configureDatePicker() {
        datePicker.datePickerMode = .date
    }
    
    private func loadHoroscopeData() {
        if let userSign = user?.sunsign {
            let urlStr = "http://sandipbgt.com/theastrologer/api/horoscope/\( userSign)/today/"
            print(urlStr)
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
