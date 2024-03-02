//
//  LoginViewController.swift
//  2-Days
//
//  Created by HAKAN ÖZER on 27.02.2024.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBAction func fncLogin(_ sender: UIButton) {
        
        let email = txtEmail.text!
        let password = txtPassword.text!
        if (email == "ali@mail.com" && password == "12345") {
            print("fncLogin Calls")
            self.dismiss(animated: true) {
                //self.performSegue(withIdentifier: "product", sender: self.btnLogin!)
                ProductViewController.email = email
                self.performSegue(withIdentifier: "product", sender: email)
            }
            
        }else {
            print("Email or password fail")
        }
        
    }
    
    @IBAction func fncRegister(_ sender: UIButton) {
        self.performSegue(withIdentifier: "register", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "product") {
            //let vc = segue.destination as! ProductViewController
            //vc.btn = sender as? UIButton
            //vc.email = sender as! String
            let vc = segue.destination as! AppNavigationController
            vc.email = sender as! String
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
