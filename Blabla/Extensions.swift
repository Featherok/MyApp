//
//  File.swift
//  Blabla
//
//  Created by Robert Pervushen on 14.12.2020.
//

import Foundation
import UIKit
import Parse

extension UIViewController {
 class func displaySpinner(onView : UIView) -> UIView {
     let spinnerView = UIView.init(frame: onView.bounds)
     spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
    let ai = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
     ai.startAnimating()
     ai.center = spinnerView.center

     DispatchQueue.main.async {
         spinnerView.addSubview(ai)
         onView.addSubview(spinnerView)
     }

     return spinnerView
 }

 class func removeSpinner(spinner :UIView) {
     DispatchQueue.main.async {
         spinner.removeFromSuperview()
     }
 }
        func hideKeyboardWhenTappedAround() {
            let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    func saveData(nameOfClass a: String, nameOfObject object: String, value valueOfObject: Any)  {
        let someTempVar = PFObject(className: a)
        someTempVar[String(object)] = valueOfObject
        someTempVar.saveInBackground { (success, error) in
            if success {
                // success
            }
            else {
               // fail
            }
    }
}
    func updateData(nameOfClass a: String, nameOfObject objectToUpdate: String, value valueOfObject: Any) {
        let query = PFQuery(className: a)
        
        query.whereKey(objectToUpdate, equalTo: PFUser.current()?.username as Any)
        query.findObjectsInBackground {
            (object, error) in
            
            if error != nil {
                print(error!)
            } else if let object = object {
                var xyu = object["jh"]
           }
        }
            
        }
    
    
    
    

}
