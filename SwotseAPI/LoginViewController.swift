//
//  LoginViewController.swift
//  SwotseAPI
//
//  Created by Sergey Leskov on 6/1/17.
//  Copyright © 2017 Sergey Leskov. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    
    //==================================================
    // MARK: - Stored Properties
    //==================================================
    @IBOutlet weak var userNameUI: UITextField!
    @IBOutlet weak var userPasswordUI: UITextField!
    
    
    //==================================================
    // MARK: - General
    //==================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameUI.delegate = self
        userPasswordUI.delegate = self
        
//        print(AppDataManager.shared.userName)
//        print(AppDataManager.shared.userToken)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //==================================================
    // MARK: - Action
    //==================================================
    
    @IBAction func signInAction(_ sender: UIButton) {
        
        let name = userNameUI.text!
        let password = userPasswordUI.text!
        
        if name == "" || password == ""  {
            let title = NSLocalizedString("Oops!", comment: "Oops")
            let message = NSLocalizedString("Not filled in all required fields!", comment: "Not filled in all required fields")
            
            MessagerManager.showMessage(title: title, message: message, theme: .error, view: self.view)
            return
        }

        
        AuthorizationManager.login(userName: userNameUI.text!, password: userPasswordUI.text!) { (error) in
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
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ nameField: UITextField) -> Bool {
        self.view.endEditing(true);
        return false;
    }
    
}
