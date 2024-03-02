//
//  ProductDetailViewController.swift
//  Product
//
//  Created by HAKAN ÖZER on 29.02.2024.
//

import UIKit
import ImageSlideshow
import SQLite

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var slideShow: ImageSlideshow!
    var item:Product!
    
    
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtPrice: UILabel!
    @IBOutlet weak var txtDetail: UITextView!
    
    
    // likes
    let db = try! Connection(Util.sqlitePath)
    let likes = Table("likes")
    let pid = Expression<Int64>("pid")
    @IBOutlet weak var btnLike: UIButton!
    @IBAction func fncLike(_ sender: UIButton) {
        let row = likes.filter(pid == Int64(item.id))
        let count = try! db.scalar(row.count)
        if count == 0 {
            // Add Like
            let result = likes.insert(pid <- Int64(item!.id))
            let rowID = try! db.run(result)
            if rowID > 0 {
                btnLike.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                btnLike.tintColor = UIColor.red
            }
        }else {
            // Delete Like
            let rowID = try! db.run(row.delete())
            if rowID > 0 {
                btnLike.setImage(UIImage(systemName: "heart"), for: .normal)
                btnLike.tintColor = UIColor.black
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var arr:[SDWebImageSource] = []
        for imgUrl in item.images {
            arr.append( SDWebImageSource(urlString: imgUrl)! )
        }
        slideShow.contentScaleMode = .scaleAspectFill
        // Click image
        let rec = UITapGestureRecognizer(target: self, action: #selector(openTop))
        slideShow.addGestureRecognizer(rec)
        slideShow.setImageInputs(arr)
        
        txtTitle.text = item.title
        txtPrice.text = "\(item.price)₺"
        txtDetail.text = item.description
        
        // likes control
        // select * from likes where pid = ?
        btnLike.tintColor = UIColor.black
        let row = likes.filter(pid == Int64(item.id))
        let count = try! db.scalar(row.count)
        if count > 0 {
            btnLike.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            btnLike.tintColor = UIColor.red
        }
        
    }
    
    @objc func openTop() {
        let full = slideShow.presentFullScreenController(from: self)
        full.slideshow.activityIndicator = DefaultActivityIndicator(style: .large, color: .white)
    }

}
