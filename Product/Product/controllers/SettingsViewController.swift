//
//  SettingsViewController.swift
//  Product
//
//  Created by HAKAN ÖZER on 29.02.2024.
//

import UIKit
import TextFieldEffects
import UserNotifications
import ImagePicker

class SettingsViewController: UIViewController, ImagePickerDelegate {

    
    
    @IBOutlet weak var txtTitle: HoshiTextField!
    @IBOutlet weak var txtSubTitle: HoshiTextField!
    @IBOutlet weak var txtDetail: HoshiTextField!
    
    let center = UNUserNotificationCenter.current()
    @IBAction func fncNotification(_ sender: UIButton) {
        
        let title = txtTitle.text!
        let subTitle = txtSubTitle.text!
        let body = txtDetail.text!
        
        // Content
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subTitle
        content.body = body
        content.sound = UNNotificationSound.default
        content.userInfo = ["product": "100"] as [String : Any]
        
        // Trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
        
        // Identifier
        let identifier = "identifierX"
        
        // Request
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        center.setBadgeCount(1)
        center.add(request) { (error) in
            if error != nil {
                print("Notificcation Error!")
            }else {
                print("Notificcation Start")
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Camera - start
    var imagePicker: ImagePickerController!
    @IBOutlet weak var profile: UIImageView!
    @IBAction func fncCamera(_ sender: UIButton) {
        let config = ImagePickerConfiguration()
        config.doneButtonTitle = "Finish"
        config.noImagesTitle = "No image!"
        config.recordLocation = false
        config.allowVideoSelection = true
        config.allowMultiplePhotoSelection = false
        
        
        imagePicker = ImagePickerController(configuration: config)
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePicker.ImagePickerController, images: [UIImage]) {
        print("wrapperDidPress")
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePicker.ImagePickerController, images: [UIImage]) {
        let image = images[0]
        self.profile.image = image
        imagePicker.dismiss(animated: true)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePicker.ImagePickerController) {
        imagePicker.dismiss(animated: true)
    }
    // Camera - end

}
