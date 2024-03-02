//
//  TabProductController.swift
//  2-Days
//
//  Created by HAKAN ÖZER on 27.02.2024.
//

import UIKit

class TabProductController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var productTableView: UITableView!
    var arr: [String] = [
            "Ahmet Yılmaz", "Ayşe Kaya", "Mehmet Özdemir", "Fatma Toprak", "Ali Kocaman",
            "Zeynep Çelik", "Mustafa Yıldız", "Gizem Arslan", "Emre Can", "Elif Şahin",
            "Burak Karadeniz", "Selin Güler", "Kadir Demir", "Ebru Akın", "Serkan Aydoğan",
            "Nur Yılmaz", "Hüseyin Kaya", "Esra Avcı", "Tolga Gür", "Derya Öztürk"
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarItem.badgeValue = "2"
        print("TabProductController Call")
        productTableView.delegate = self
        productTableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = productTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let title = arr[indexPath.row]
        cell.textLabel?.text = title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = arr[indexPath.row]
        self.performSegue(withIdentifier: "detail", sender: title)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detail") {
            let vc = segue.destination as! DetailViewController
            vc.userName = sender as! String
        }
    }
    


}
