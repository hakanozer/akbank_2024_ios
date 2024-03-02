//
//  ProductViewController.swift
//  Product
//
//  Created by HAKAN ÖZER on 28.02.2024.
//

import UIKit
import Alamofire
import SDWebImage
import ProgressHUD

class ProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var arr:[Product] = []
    @IBOutlet weak var productTableView: UITableView!
    let refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productTableView.dataSource = self
        productTableView.delegate = self
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        refresh.addTarget(self, action: #selector(productResult), for: .valueChanged)
        self.productTableView.addSubview(refresh)
        productResult()
    }
    
    
    @objc func productResult() {
        ProgressHUD.show()
        ProgressHUD.animationType = .circleStrokeSpin
        let url = "https://dummyjson.com/products"
        AF.request(url).responseData { res in
            let status = res.response?.statusCode
            if (status == 200) {
                let data = res.data
                if (data != nil) {
                    let productModel = try? JSONDecoder().decode(ProductsModel.self, from: data!)
                    if (productModel != nil) {
                        self.arr = productModel!.products
                        self.refresh.endRefreshing()
                        self.productTableView.reloadData()
                        ProgressHUD.dismiss()
                    }
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


}
