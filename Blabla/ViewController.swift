//
//  ViewController.swift
//  Blabla
//
//  Created by Robert Pervushen on 27.01.2021.
//

import UIKit
import AudioToolbox
import Parse
class ViewController: UIViewController {


    override func viewDidLoad() {
        let q = PFQuery(className: "UserSettings")
        q.whereKey("userName", equalTo: PFUser.current()?.username as Any)
        q.findObjectsInBackground {
            (objectToFind, error) in
            if let objects = objectToFind {
                for object in objects {
                    self.userName.text = object["userNic"] as? String
                }
            } else {
                print(false)
            }
        }

//        let notificationCenter = NotificationCenter.default
//        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)

    
        super.viewDidLoad()
        ViewController.x = 0
        

        
        self.hideKeyboardWhenTappedAround()
        nameForUser.isUserInteractionEnabled = false

    }
    
    @objc func appMovedToBackground() {
        let currentUser = PFUser.current()
        if currentUser != nil {
            updateData(nameOfClass: "UserSettings", nameOfObject: "userNic", value: userName.text as Any)
        }

    }
    
    static var x = 0
    var showAlert = true
    override open var shouldAutorotate: Bool {

        return false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if PFUser.current() == nil {
            print("its nil")
            self.loadHomeScreen()
        }
        super.viewDidAppear(false)

        
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
        self.present(alertView, animated: false, completion: nil)
    }

    
    @IBOutlet var nameForUser: UITextField!
    {
        didSet {
//            hideKeyboardWhenTappedAround()
            nameForUser.borderStyle = .none
            

        }
      }
    @IBOutlet var userName: UILabel! {
        didSet {
            
            
        }
    }
    @IBOutlet var tapAndSav: UIButton!
    @IBAction func tapAndSave(_ sender: Any) {
        if nameForUser.text?.isEmpty == true {
            userName.text = "*user*"
        } else {
            userName.text = nameForUser.text
        }
        nameForUser.isUserInteractionEnabled = false
        tapAndSav.isHidden = true
        nameForUser.isHidden = true
        userName.isHidden = false
        
    }
    @IBAction func editButtton(_ sender: Any) {
        nameForUser.text = userName.text
        nameForUser.becomeFirstResponder()
        nameForUser.selectAll(nil)
//        nameForUser
        userName.isHidden = true
        nameForUser.isUserInteractionEnabled = true
        nameForUser.isHidden = false
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        tapAndSav.isHidden = false
        nameForUser.becomeFirstResponder()
        
    }
    
    
    
    @IBAction func logOutTheApp(_ sender: UIButton) {

        let sv = UIViewController.displaySpinner(onView: self.view)
        PFUser.logOutInBackground { (error: Error?) in
            UIViewController.removeSpinner(spinner: sv)
            if (error == nil){
                self.loadHomeScreen()
            }else{
                if let descrip = error?.localizedDescription{
                    self.displayErrorMessage(message: descrip)
                }else{
                    self.displayErrorMessage(message: "error logging out")
                }

            }
        }
    }
    func loadHomeScreen() {
        let homeSettings = storyboard?.instantiateViewController(identifier: "SettingsPage")
        homeSettings?.modalPresentationStyle = .fullScreen
        
        present(homeSettings!, animated: true)
        
    }

    static var score = [String]()
    @IBAction func didTapButton() {
          
        let vc = storyboard?.instantiateViewController(identifier: "second")
        let alert = UIAlertController(title: "You're obliged to read this", message: "Enable feature of resetting counter by tapping itself?", preferredStyle: UIAlertController.Style.alert)
        present(vc!, animated: true)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Sure", style: UIAlertAction.Style.default, handler: { action in
            print("true")
            ViewControllerAnother.personChoise = true
        }))
        alert.addAction(UIAlertAction(title: "I'd rather reload the view", style: UIAlertAction.Style.destructive, handler: { action in
            print("false")
            ViewControllerAnother.personChoise = false
            
        }))
        
        

        // show the alert
        if showAlert {
        vc!.present(alert, animated: true, completion: nil)
            showAlert = false
        }
        UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
        
        

    }


}
