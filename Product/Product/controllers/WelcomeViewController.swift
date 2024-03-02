//
//  WelcomeViewController.swift
//  Product
//
//  Created by HAKAN ÖZER on 28.02.2024.
//

import UIKit
import Alamofire

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let device = UIDevice.current
        print(device.batteryLevel, device.batteryState, device.systemName, device.systemVersion, device.localizedModel)
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        print(path!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { Timer in
            self.control()
        }
    }
    
    
    func control() {
        let user = Util.userGet()
        if (user != nil) {
            let jwt = user!.token
            let url = "https://dummyjson.com/auth/me"
            let header:HTTPHeaders = ["Authorization": "Bearer \(jwt)"]
            AF.request(url, method: .get, headers: header).responseData { res in
                let status = res.response?.statusCode
                if (status == 200) {
                    self.performSegue(withIdentifier: "app", sender: nil)
                }else {
                    self.performSegue(withIdentifier: "login", sender: nil)
                }
            }
        }else {
            self.performSegue(withIdentifier: "login", sender: nil)
        }
        
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }


}
