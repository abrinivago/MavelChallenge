//
//  AuthViewController.swift
//  MarvelChallenge
//
//  Created by Antonella Brini Vago on 16/03/2022.
//

import UIKit
import Firebase
import FirebaseAuth

class AuthViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sessionVerify()
        self.emailTextfield.text = "semevuelaelsombrero@msn.net"
        self.passwordTextfield.text = "Carpinchocolorado1"
    }
    
    func sessionVerify(){
        if UserSession.sessionVerify != nil {
            let vc = TabBarViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func createAccountButtonAction(_ sender: Any) {
        if let email = emailTextfield.text,
           let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let result = result, error == nil {
                    UserSession.buildWithUid(result.user.uid)
                    let vc = TabBarViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let alertController = UIAlertController(title: "Error", message: "Se ha producido un error registrando el usuario", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        if let email = emailTextfield.text,
           let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let result = result, error == nil {
                    UserSession.buildWithUid(result.user.uid)
                    let vc = TabBarViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let alertController = UIAlertController(title: "Error", message: "Se ha producido un error registrando el usuario", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
