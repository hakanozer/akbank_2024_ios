//
//  LoginViewController.swift
//  Product
//
//  Created by HAKAN ÖZER on 28.02.2024.
//

import UIKit
import SCLAlertView
import Alamofire

class LoginViewController: UIViewController {

    
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBAction func fncLogin(_ sender: UIButton) {
        let username = txtUserName.text!
        let password = txtPassword.text!
        if (username == ""){
            SCLAlertView().showWarning("Empty!", subTitle: "Username Empty!")
            txtUserName.becomeFirstResponder()
        }else if (password == "") {
            SCLAlertView().showWarning("Empty!", subTitle: "Password Empty!")
            txtPassword.becomeFirstResponder()
        }else {
            // Form Send
            let url = "https://dummyjson.com/auth/login"
            let sendObj = ["username": username, "password": password]
            AF.request(url, method: .post, parameters: sendObj ).responseData { res in
                let status = res.response?.statusCode
                if (status == 200) {
                    let data = res.data
                    let userModel = try? JSONDecoder().decode(UserModel.self, from: data!)
                    Util.userStore(data: userModel!)
                    self.performSegue(withIdentifier: "app", sender: nil)
                }else {
                    SCLAlertView().showError("Error", subTitle: "Username or Password Fail!")
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        txtUserName.resignFirstResponder()
        txtPassword.resignFirstResponder()
        for item in touches {
            let x = item.location(in: self.view).x
            let y = item.location(in: self.view).y
            print(x, y)
        }
    }
    

}
