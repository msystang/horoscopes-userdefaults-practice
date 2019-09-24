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
    
    
    var horoscope: Horoscope? {
        didSet {
            sunsignLabel.text = horoscope?.sunsign
        }
    }
    
    var name: String = "" {
        didSet {
            welcomeLabel.text = "Welcome " + self.name + "!"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        configureDatePicker()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadHoroscopeData()
    }

    @IBAction func pickBirthday(_ sender: UIDatePicker) {
    }
    
    private func configureDatePicker() {
        datePicker.datePickerMode = .date
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
