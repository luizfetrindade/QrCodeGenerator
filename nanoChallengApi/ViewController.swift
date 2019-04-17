//
//  ViewController.swift
//  nanoChallengApi
//
//  Created by Luiz Felipe Trindade on 16/04/19.
//  Copyright © 2019 Luiz Felipe Trindade. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    @IBOutlet weak var linkTextField: UITextField?
    @IBOutlet weak var qrCodeView: UIImageView?
    @IBOutlet weak var doneLabel: UILabel!
    @IBOutlet weak var loadIcon: UIActivityIndicatorView!
    @IBOutlet weak var convertButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        convertToQrCodeButton((Any).self)
        doneLabel.isHidden = true
        convertButton.layer.cornerRadius = 15
        convertButton.layer.borderWidth = 0.5
        convertButton.layer.borderColor = UIColor.white.cgColor
        loadIcon.isHidden = true
    }
    
    
    @IBAction func convertToQrCodeButton(_ sender: Any) {
        qrCodeView?.isHidden = true
        
        loadIcon.isHidden = false
        let req : Request = Request.init()
        req.makeGetCall(data: (linkTextField?.text)!, size: "30", completionHandler: { (image) in
            if let img = image{
                self.qrCodeView?.isHidden = false
                self.qrCodeView?.image = img
                self.loadIcon.isHidden = true
            }
        })
        if linkTextField?.text != "" {
            doneLabel.text = "QrCode For: \((linkTextField?.text)!)"
            doneLabel.isHidden = false
            linkTextField?.text = nil
            view.endEditing(true)
        }
    }
    

    
    
    @IBAction func shareItem(_ sender: UIBarButtonItem) {
        if qrCodeView?.image != nil{
            let imageToShare = [ qrCodeView?.image! ]
            
            let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view 
            
            activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
            
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
}

