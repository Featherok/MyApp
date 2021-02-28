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
    func saveData(nameOfClass a: String, nameOfObject object: String, value valueOfObject: Any, secondObject: String? = nil, secondValue: Any? = nil, thirdObject: String? = nil, thirdValue: Any? = nil, fourthValue: Any? = nil)  {
        let someTempVar = PFObject(className: a)
        if secondValue == nil {
        someTempVar[object] = valueOfObject
        } else if thirdValue == nil {
            someTempVar[object] = valueOfObject
            someTempVar[secondObject!] = secondValue
        } else if fourthValue == nil{
            someTempVar[object] = valueOfObject
            someTempVar[secondObject!] = secondValue
            someTempVar[thirdObject!] = thirdValue
        } else {
            someTempVar[object] = valueOfObject
            someTempVar[object] = secondValue
            someTempVar[object] = thirdValue
            someTempVar[object] = fourthValue
        }
        someTempVar.saveInBackground { (success, error) in
            if success {
                // success
            }
            else {
               // fail
            }
    }
}
    func updateData(nameOfClass a: String, nameOfObject objectWithShit: String, value valueOfObject: Any) {
        let upQeury = PFQuery(className: a)
//        let upObject = PFObject(className: a)
        
        if let currentUserName = PFUser.current()?.username {
            upQeury.whereKey("userName", equalTo: currentUserName)
        }
        
        upQeury.findObjectsInBackground { (objects, error) in
            
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        print(object)
                        print(object.objectId!)
                        upQeury.getObjectInBackground(withId: object.objectId!){ (upObject, error) in
                            if error != nil {
                                
                            } else if let upObject = upObject {
                                upObject[objectWithShit] = valueOfObject
                                print(upObject[objectWithShit])
                                print("updated success")
                                upObject.saveInBackground()
                            }
                        }
                    }
                }
            }
            
        }

    }
    
}
