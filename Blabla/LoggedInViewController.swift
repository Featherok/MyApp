//
//  LoggedInViewController.swift
//  Blabla
//
//  Created by Robert Pervushen on 17.02.2021.
//

import Foundation
import UIKit
import Parse

class LoggedInViewController:
    UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        
    }
    func loadHomeScreen() {
        let homePage = storyboard?.instantiateViewController(identifier: "main")
        homePage?.modalPresentationStyle = .fullScreen
        present(homePage!, animated: true)
        
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    @IBOutlet fileprivate var textFieldUserName: UITextField!
    
    @IBOutlet fileprivate var textFieldUserPassword: UITextField!
    
    @IBAction func singUp(_ sender: UIButton) {
        saveData(nameOfClass: "UserSettings", nameOfObject: "userName", value: textFieldUserName.text!)
        saveData(nameOfClass: "UserSettings", nameOfObject: "userNic", value: textFieldUserName.text!)
        
        
        let user = PFUser()
        user.username = textFieldUserName.text
        user.password = textFieldUserPassword.text
        
        let sv = UIViewController.displaySpinner(onView: self.view)
        user.signUpInBackground { (success, error) in
            UIViewController.removeSpinner(spinner: sv)
            if success {
                self.loadHomeScreen()
            }else {
                if let descrip = error?.localizedDescription{
                    self.displayErrorMessage(message: descrip)
                }
            }
            
        }
        
    }
    
    
    @IBAction func logIn(_ sender: UIButton) {

        let userName: String = self.textFieldUserName.text!
        let password: String = self.textFieldUserPassword.text!
        
        
        let sv = UIViewController.displaySpinner(onView: self.view)
        
        
        PFUser.logInWithUsername(inBackground: userName, password: password) { (user, error) in
            UIViewController.removeSpinner(spinner: sv)
            if (user != nil) {
                
                self.loadHomeScreen()
                
            }else {
                if let descrip = error?.localizedDescription{
                    self.displayErrorMessage(message: descrip)
                }
            }
            
        }
    }
    
    func displayErrorMessage(message:String) {
        let alertView = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
        }
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        self.present(alertView, animated: true, completion:nil)
    }
    
}
