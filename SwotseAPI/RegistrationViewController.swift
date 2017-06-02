//
//  RegistrationViewController.swift
//  SwotseAPI
//
//  Created by Sergey Leskov on 6/1/17.
//  Copyright © 2017 Sergey Leskov. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    //==================================================
    // MARK: - Stored Properties
    //==================================================
    @IBOutlet weak var nameUI: UITextField!
    @IBOutlet weak var eMailUI: UITextField!
    @IBOutlet weak var passwordUI: UITextField!
    
    
    //==================================================
    // MARK: - General
    //==================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameUI.delegate = self
        eMailUI.delegate = self
        passwordUI.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func registrationAction(_ sender: UIButton) {
        
        let name = nameUI.text!
        let password = passwordUI.text!
        let eMail = eMailUI.text!
        
        if name == "" || password == "" || eMail == "" {
            let title = NSLocalizedString("Oops!", comment: "Oops")
            let message = NSLocalizedString("Not filled in all required fields!", comment: "Not filled in all required fields")
            
            MessagerManager.showMessage(title: title, message: message, theme: .error, view: self.view)
            return
        }
        
        
        AuthorizationManager.registration(userName: name, eMail: eMail, password: password) { (error) in
            if let error = error  {
                MessagerManager.showMessage(title: "Error", message: error, theme: .error, view: self.view)
                return
            }
            
            MessagerManager.showMessage(title: "Success", message: "", theme: .success, view: self.view)
            
            self.performSegue(withIdentifier: "showUsers", sender: nil)
        }
        
    }
    
    //==================================================
    // MARK: - navigation
    //==================================================
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUsers" {
        }
    }
    
    
}


//==================================================
// MARK: - UITextFieldDelegate
//==================================================
extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ nameField: UITextField) -> Bool {
        self.view.endEditing(true);
        return false;
    }
    
}
