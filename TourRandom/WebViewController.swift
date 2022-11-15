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
        
        // 要跑 webView 須先 import WebKit
        // 將 URL 的 method 選擇用 String type 填入字串做導向順便做 optional binding,最後用 URLReuest 做 request 給 webView 做 method 的 load.
        if let url = URL(string: "https://www.travel.taipei/zh-tw") {
        let request = URLRequest(url: url)
        webView.load(request)
        }
        
        
        }
     
    
    
    
    
    
    
}


