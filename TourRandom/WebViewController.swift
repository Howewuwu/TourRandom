//
//  WebViewController.swift
//  TourRandom
//
//  Created by Howe on 2022/10/6.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let url = URL(string: "https://www.travel.taipei/zh-tw") {
        let request = URLRequest(url: url)
        webView.load(request)
        }
        
        
        }
     
    
    
    
    
    
    
}


