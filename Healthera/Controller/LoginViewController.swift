//
//  ViewController.swift
//  Healthera
//
//  Created by yaser on 9/30/18.
//  Copyright © 2018 Barsam. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    override func viewDidLayoutSubviews() {
        emailTextField.setBottomLine(borderColor: UIColor.lightGray)
        passwordTextField.setBottomLine(borderColor: UIColor.lightGray)
        loginButton.setConrnerRadius(radius: 5)

    }
    
    
    @IBAction func loginBtn(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != ""{
            loginButton.isEnabled = false
            AuthenticationService.shared.Login(username: emailTextField.text!, password: passwordTextField.text!) { (result) in
                switch result {
                case .success(let value):
                    KeychainAccess.shared.setTokenIdOnKeychain(token: value.token!)
                    KeychainAccess.shared.setUserId(user_id: value.user_id!)
                    
                    self.loginButton.isEnabled = true
                    
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    
                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: "Adherences")
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                    
                case .failure(let error):
                    let alertController = UIAlertController(title: "Fail", message: "\(error)", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    self.loginButton.isEnabled = true
                }
            }
        }else{
            let alertController = UIAlertController(title: "Alert", message: "You should fill the username or password!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}



