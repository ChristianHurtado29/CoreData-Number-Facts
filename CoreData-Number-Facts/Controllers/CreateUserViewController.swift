//
//  CreateUserViewController.swift
//  CoreData-Number-Facts
//
//  Created by Christian Hurtado on 4/8/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

protocol CreateUserDelegate: AnyObject {
    func didCreateUser(_ createUserViewController: CreateUserViewController, user: User)
}

class CreateUserViewController: UITableViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate: CreateUserDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set a maximum date of today
        datePicker.maximumDate = Date()
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        guard let usernameText = usernameTextField.text, !usernameText.isEmpty  else {
            print("missing username")
            return
        }
        
        let date = datePicker.date
        
        // create a user
        let user = CoreDataManager.shared.createUser(name: usernameText, dob: date)
        
        // call delegate method
        delegate?.didCreateUser(self, user: user)
        // UserViewController will now have access to the created user and get a delegation notification about the new user
        
        dismiss(animated: true)
    }
}
