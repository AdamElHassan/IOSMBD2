//
//  LoginViewController.swift
//  SocialApp
//
//  Created by User on 28/02/2019.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    private var apiLoginController : ApiLoginController = ApiLoginController()
    private var activityIndicator : UIActivityIndicatorView?
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var logoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLogo()
        self.activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        view.addSubview(self.activityIndicator!)
        self.activityIndicator?.center = view.center
        self.activityIndicator?.hidesWhenStopped = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        var keychainPassword = ""
        let username = UserDefaults.standard.value(forKey: "username")
        if (username != nil) {
            do {
                let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                        account: username as! String,
                                                        accessGroup: KeychainConfiguration.accessGroup)
                keychainPassword = try passwordItem.readPassword()
                self.usernameTextField.text = username as? String
                self.passwordTextField.text = keychainPassword
                self.login()
            } catch {
                return
            }
        }
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        self.login()
    }
    
    func login() {
        guard let username = self.usernameTextField.text else { return }
        guard let password = self.passwordTextField.text else { return }
        if (username.isEmpty || password.isEmpty) {
            let alert = UIAlertController(title: "Fout", message: "Vul beide velden in.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Sluiten", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        self.disableTextInput()
        self.startActivityIndicator()
        self.apiLoginController.login(username: username, password: password) { profile in
            if (profile == nil) {
                let alert = UIAlertController(title: "Fout", message: "Ongeldige logingegevens.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Sluiten", style: .default, handler: nil))
                self.present(alert, animated: true)
                self.enableTextInput()
                self.passwordTextField.text = ""
                self.activityIndicator?.stopAnimating()
            } else {
                UserDefaults.standard.setValue(username, forKey: "username")
                do {
                    let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: username,accessGroup: KeychainConfiguration.accessGroup)
                    try passwordItem.savePassword(password)
                } catch {
                    fatalError("Error updating keychain - \(error)")
                }
                UserDefaults.standard.set(true, forKey: "hasLoginKey")
            let storyBoard: UIStoryboard!
                storyBoard = UIStoryboard(name: "Main", bundle: nil)
                print(storyBoard)
                let GamesViewController = storyBoard.instantiateViewController(withIdentifier: "GamesOverview") as! UINavigationController
                print(GamesViewController)
                self.present(GamesViewController, animated: true, completion: nil)
                self.activityIndicator?.stopAnimating()
            }
        }
    }
    
    func disableTextInput() {
        self.usernameTextField.isUserInteractionEnabled = false
        self.passwordTextField.isUserInteractionEnabled = false
        self.usernameTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    func enableTextInput(){
        self.usernameTextField.isUserInteractionEnabled = true
        self.passwordTextField.isUserInteractionEnabled = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardHide() {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    @objc func keyboardShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            print(keyboardHeight)
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            scrollView.scrollIndicatorInsets = scrollView.contentInset
        }
    }
    
    func startActivityIndicator() {
        self.activityIndicator?.startAnimating()
    }
    func setLogo(){
        // Getting a random picture
        let number = Int.random(in: 0 ..< 10)
        self.apiLoginController.setLogo(number: String(number)) { data in
            if (data != nil) {
                self.logoImage.image = UIImage( data:data!)
            } else {
               
            }
        }
    }
    
}
