//
//  SettingsViewController.swift
//  tic tac toe (remake)
//
//  Created by Андрей Журавлев on 15.01.2020.
//  Copyright © 2020 Андрей Журавлев. All rights reserved.
//

import UIKit
import os.log

struct Settings {
    var crossName = "Cross"
    var circleName = "Circle"
    var isAI = Players.none
}

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var crossTextField: UITextField!
    @IBOutlet weak var circleTextField: UITextField!
    @IBOutlet weak var crossSwitch: UISwitch!
    @IBOutlet weak var circleSwitch: UISwitch!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //MARK: Properties
    var settings: Settings!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    
    //MARK: Actions
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }

        settings = Settings()
        settings.circleName = circleTextField.text!
        settings.crossName = crossTextField.text!
        if crossSwitch.isOn {
            settings.isAI = .Cross
        } else if circleSwitch.isOn{
            settings.isAI = .Circle
        }

    }
    

}
