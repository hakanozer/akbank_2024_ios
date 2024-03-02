//
//  LikesViewController.swift
//  Product
//
//  Created by HAKAN ÖZER on 29.02.2024.
//

import UIKit
import SQLite
import Alamofire
import SDWebImage
import ProgressHUD

class LikesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arr:[Product] = []
    @IBOutlet weak var productTableView: UITableView!
    
    
    let db = try! Connection(Util.sqlitePath)
    let likes = Table("likes")
    let lid = Expression<Int64>("lid")
    let pid = Expression<Int64>("pid")

    override func viewDidLoad() {
        super.viewDidLoad()
        productTableView.dataSource = self
        productTableView.delegate = self
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        dataResult()
    }
    
    func dataResult() {
        arr = []
        self.productTableView.reloadData()
        for item in try! db.prepare(likes) {
            //let dbLid = item[lid]
            let dbPid = item[pid]
            let url = "https://dummyjson.com/products/\(dbPid)"
            ProgressHUD.show()
            ProgressHUD.animationType = .circleStrokeSpin
            AF.request(url).responseData { res in
                let data = res.data
                if (data != nil) {
                    let product = try! JSONDecoder().decode(Product.self, from: data!)
                    self.arr.append(product)
                    self.productTableView.reloadData()
                    ProgressHUD.dismiss()
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productTableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let item = arr[indexPath.row]
        
        cell.r_title.text = item.title
        cell.r_price.text = "\(item.price)₺"
        
        /*
        let url = URL(string: item.thumbnail)
        let data = try? Data(contentsOf: url!)
        cell.r_img.image = UIImage(data: data!)
         */
        cell.r_img.sd_setImage(with: URL(string: item.thumbnail))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = arr[indexPath.row]
        self.performSegue(withIdentifier: "productDetail", sender: item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "productDetail") {
            let vc = segue.destination as! ProductDetailViewController
            vc.item = sender as? Product
        }
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if (indexPath.row == 2) {
            return true
        }
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pidRow = arr[indexPath.row].id
            let row = likes.filter(pid == Int64(pidRow))
            // Delete Like
            let rowID = try! db.run(row.delete())
            if rowID > 0 {
                self.arr.remove(at: indexPath.row)
                self.productTableView.beginUpdates()
                self.productTableView.deleteRows(at: [indexPath], with: .top)
                self.productTableView.endUpdates()
            }
        }
    }
    
    

}
