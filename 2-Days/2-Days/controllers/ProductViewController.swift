//
//  ProductViewController.swift
//  2-Days
//
//  Created by HAKAN ÖZER on 27.02.2024.
//

import UIKit

class ProductViewController: UIViewController {
    
    @IBOutlet weak var lblEmail: UILabel!
    static var email:String = ""
    var btn:UIButton!
    
    @IBAction func gotoDetail(_ sender: UIButton) {
        self.performSegue(withIdentifier: "detail", sender: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        lblEmail.text = ProductViewController.email
        //btn.backgroundColor = UIColor.red
        //self.view.addSubview(btn)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
