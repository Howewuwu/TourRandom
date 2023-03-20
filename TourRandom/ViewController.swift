//
//  ViewController.swift
//  TourRandom
//
//  Created by Howe on 2022/10/4.
//
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // function 名為 viewWillAppear 意思就是當這個畫面出現時，你要這串 code 做什麼，而這個畫面只的就是目前這個主畫面 (ViewController)
    // 將主 view 上的 navigation bar 的 title 給隱藏.
    // 現在是到 Main 上去勾選 navigation controller 的 bar 的 standard & scroll edge (該畫面的呈現方式需對應對的選項，比如有 scroll 的畫面，勾了 scroll edge 並修改它的子選項，該畫面的 navigation bar 才會跟著更動.) 可參考 https://medium.com/%E5%BD%BC%E5%BE%97%E6%BD%98%E7%9A%84-swift-ios-app-%E9%96%8B%E7%99%BC%E5%95%8F%E9%A1%8C%E8%A7%A3%E7%AD%94%E9%9B%86/%E8%AE%93-navigation-bar-%E6%88%96-tab-bar-%E6%8D%B2%E5%8B%95%E8%B7%9F%E4%B8%8D%E6%8D%B2%E5%8B%95%E6%99%82%E9%83%BD%E7%B6%AD%E6%8C%81%E5%90%8C%E4%B8%80%E7%A8%AE%E6%A8%A3%E5%BC%8F-4dec94143b51
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
 
    
    
    // 當這個畫面消失時你要這串 code 做什麼，就是要讓 navigation 的 bar 再次出現.
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
     }
  
    
    
    // 已在 Main 上做 segue 連結 webviewcontroller 的畫面.
    @IBAction func webButton(_ sender: Any) {}
   
    
    
    // 重複連接所有的 buttton 做 pushViewController，是藉由 button 的 title 比如臺北市然後找到對應的 API 資料進行連結
    // if let str = btn.titleLabel?.text { detialVC.cate = str 這一行就是利用 button 的 title 去對 detailcontroller 的 API 資訊.
    // as 的作用就是把某個東西給當成什麼東西，但類型應該是要一樣的.
    // storyboard.insantiateViewController(withIdentifier: )，withIdentifier: 這個要填的是在 Main 上將 DetailViewController 的 identity inspectior 的 storyboardID.
    @IBAction func tourButton(_ sender: Any) {
        
        let detialVC = storyboard?.instantiateViewController(withIdentifier: "detailVC")as! DetailViewController
        let btn = sender as! UIButton
        if let str = btn.titleLabel?.text
        {
        detialVC.cate = str
        navigationController?.pushViewController(detialVC, animated: true )
        }
        
        
    }

    
    @IBAction func randomBtn(_ sender:UIButton){
        let viewArray = ["臺北市","臺中市","高雄市","新北市","基隆市","宜蘭縣","花蓮縣","新竹市","苗栗縣","南投縣","臺南市","嘉義市","臺東縣","桃園市","屏東縣","彰化縣","雲林縣","新竹縣"]
        let randomInt = Int.random(in: 0...12)
        let randomDecide = viewArray[randomInt]
        
        let detialVC = storyboard?.instantiateViewController(withIdentifier: "detailVC")as! DetailViewController
       
        detialVC.cate = randomDecide
        navigationController?.pushViewController(detialVC, animated: true )
    }
    
    
    
    
    
    }

// 蘋果預設的網路安全須開啟允許才能設置 API，  需在 info 增加一個 Row (右鍵彈出視窗) 名為 App Transport Security Settings 然再增加子選項 Allow Arbitrary Loads 接著 Value 設為 YES，但這不是比較好的做法，較好的作法為子選項選取 Exception 那個，但之後再說吧.
