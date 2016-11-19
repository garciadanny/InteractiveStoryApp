//
//  ViewController.swift
//  InteractiveStory
//
//  Created by Danny Garcia on 11/11/16.
//  Copyright © 2016 Danny Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

  enum NameError: Error {
    case noName
  }
  
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var textFieldBottomConstraint: NSLayoutConstraint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view, typically from a nib.
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(ViewController.keyboardWillShow(notification:)),
      name: NSNotification.Name.UIKeyboardWillShow,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(ViewController.keyboardWillhide),
      name: NSNotification.Name.UIKeyboardWillHide,
      object: nil
    )
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "startAdventure" {

      
      do {
        if let name = nameTextField.text {
          if name == "" {
            throw NameError.noName
          }
          
          if let pageController = segue.destination as? PageController {
            pageController.page = Adventure.story(name: name)
          }
        }
      } catch NameError.noName {
          let alertController = UIAlertController(
            title: "Name Not Provided",
            message: "Provide a name to start your story!",
            preferredStyle: .alert
          )
          let action = UIAlertAction(title: "OK", style: .default, handler: nil)
          alertController.addAction(action)
          present(alertController, animated: true, completion: nil)
      } catch let error {
          fatalError("\(error)")
      }
    }
  }
  
  func keyboardWillShow(notification: Notification) {
    if let userInfoDict = notification.userInfo,
      let keyboardFrameValue = userInfoDict[UIKeyboardFrameEndUserInfoKey] as? NSValue {
      let keyboardFrame = keyboardFrameValue.cgRectValue
      
      UIView.animate(withDuration: 0.8) {
        self.textFieldBottomConstraint.constant = keyboardFrame.size.height + 10
        self.view.layoutIfNeeded()
      }
    }
  }
  
  func keyboardWillhide() {
    UIView.animate(withDuration: 0.8) {
      self.textFieldBottomConstraint.constant = 33
      self.view.layoutIfNeeded()
    }
  }
  
  // MARK: - UITextFieldDelegate
  
  /*
   Optional requirement of UITextFieldDelegate
   gets called when the done button on the keyboard is pressed
   the boolean specifies whether the text field should process the done button
   when it is pressed.
  */
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}

