//
//  DetailViewController.swift
//  TourRandom
//
//  Created by Howe on 2022/10/6.
//

import UIKit
import MapKit


class DetailViewController: UIViewController {
    
    var cate = "" // 接收 viewController 的 button title 做為分類 data 的基礎點。
    var viewsArray =  [taiwanTourViews.Tourviews.views.view]() //存取接收到的資料用的 array，需跟著 struct 的格式制定。
    //@IBOutlet weak var naviTitle: UINavigationBar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textView2: UITextView!
    
    // 依照 JSON 的排列給予 struct 同樣排列和正確的型態（需與 JSON 的 Key 相同 （XML_Head,Infos,Info））
    struct taiwanTourViews : Codable {
        var XML_Head : Tourviews
        struct Tourviews : Codable{
            var Infos : views
            struct views : Codable{
                var Info : [view]
                struct view : Codable{
                    var Name : String?
                    var Toldescribe : String?
                    var Description : String?
                    var Tel : String?
                    var Add : String?
                    var Region : String?
                    var Town : String?
                    var Px : Double?
                    var Py : Double?
    }
    }
    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(cate)
        
        getData()
        
        self.navigationController?.topViewController?.title = "請稍等"
        
    }
    
   
    // 獲取資料的一個大 function
    func getData (){
        
        // 藉由 URL 去該網頁獲取資料
        let url = URL(string: "https://media.taiwan.net.tw/XMLReleaseALL_public/scenic_spot_C_f.json")
        
        // 網址資料獲取用 URLSession.shared.dataTask(with: )，獲取到後用 closure {(data,reponse,error) in}.resume() 這個大 closure 去執行要做的事
        // data,reponse,error 是預設的動作（參數），所以不用給 type，in 就是在“什麼“裡面（就 closure ）。
        // 如果有成功獲取資料的話會存放在 data 裡面，reponse 負責網頁給的回應（產生什麼樣的回應 ），error 負責錯誤
        URLSession.shared.dataTask(with: url!) {(data,reponse,error) in
            if let errorDes = error{
                print(errorDes.localizedDescription) //有錯誤時將 error 給印出，localizedDescription 看起來是固定 method.
        }
        
        // 開始使用上面獲取的 data 裡的資料
           
            // 做 decode 可能會產生錯誤，Swift 怕有錯誤產生，所以要求用 do,catch 做萬一 → do {} catch let jsonError { print(jsonError) }
            // 在 do catch 裡面才可以做解碼，在裡面用 try，因為它可能會出了問題
            // 先用 optional binding 保證上面的 closure 裡的 data 有獲取到資料
            // 用 try 去做 JSONDecoder().decode，後面的 taiwanTourView 要加 .self 好像是固定的但我還不知道為何，data 則就是上面的 data
            // 目前到這樣是獲取到整筆資料，所以用 for in 讓資料一筆一筆進來，而需要的資料是在 Info 這層
            // 使用 viewController 那裡的 button title 做為篩選去對應 Info(目前是指定為 view) 這個 array 裡面的 Region / if self.cate == view.Region
            // 將過濾後的資料過給(append)這裡的 array(viewArray) / self.viewsArray.append(view)
            do {
                if let data = data {
                    let viewData = try JSONDecoder().decode(taiwanTourViews.self, from: data)
                    for view in viewData.XML_Head.Infos.Info {
                        
                        if self.cate == view.Region {
                            self.viewsArray.append(view) // 但還不明白為何都要加 self.
                            
                  }
                 }
                }
                // DispathQueue 需在外面執行，老師是說因為它是一個 Closure 的關係，但我聽不是很懂。
                // 將內容放在畫面上是運用 DispathQueue
                // 需在多研究 DispathQueue 相關資訊 / async&await ❗️❗️❗️❗️
                DispatchQueue.main.async {
                    // 利用 arc4random_uniform 產生一個隨機變數，.count 指的是 viewArray 裡所有資料的總數量。
                    // arc4random_uniform 只能用 UInt32 辨識，所以用它來包裹著 (self.viewArray.count).
                    // 但因為下一行 let vi = self.viewArray[randomNum]，self.viewArray[randomNum] 只能用 Int，所以 arc4random_uniform(UInt32(self.viewsArray.count)) 再用 Int 包裹。
                    let randomNum = Int(arc4random_uniform(UInt32(self.viewsArray.count)))
                    let vi = self.viewsArray [randomNum] // 一個 Array [數字] → Array 裡的第”幾“個 資料
                    self.navigationController?.topViewController?.title = vi.Name // 將名稱顯示在 navigationBar title 上
                    //self.title = vi.Name
                    self.textView.text = vi.Toldescribe // 將內容顯示在 textView 上
                    self.textView2.text = vi.Add // 將地址顯示在小 textView 上
                    let location = CLLocation(latitude: (vi.Py)!, longitude: (vi.Px)!) // 用 CLLocation 獲取資料裡的經緯度指定給變數。
                    self.centerMapOnLocation(location: location) // 呼叫移動 mapView 的 function 將經緯度的變數帶入。
                    let pin = MKPointAnnotation() // 先產生一個地圖標示，用這個 → MKPointAnnotation()
                    pin.coordinate = location.coordinate // 將從資料獲取的座標帶給要產生的地圖標示
                    self.mapView.addAnnotation(pin) // 確定讓地圖標示出現 
                }
             // catch let jsonError { print(jsonError) } 這段目前看起來似乎是固定用法，只用 Error 好像也可以？
            }catch let jsonError {
                print(jsonError)
            }
            
        }.resume() //最後需加上 .resume() 才可以將資料拿回
        }
    
    
    
    
    
    
    // 移動地圖中心點的 function，利用 CLLocation 的方式（它是用經緯度的方式去構成）。
    // 參數型態用 CLLocation
    // MKCoordinateRegion 的大略解釋：⎡以特定緯度和經度為中心的矩形地理區域。⎦
    // 運用 MKCoordinateRegion 將中心點移到該位置
    // MKCoordinateRegion(center: “內部參數名”.coordinate, latitudinalMeters: ”放大倍率“, longitudinalMeters: ”放大倍率“)
    // mapView.setRegion("上面的數據變數帶入", animated: true) → 將數據帶入後確實移動 mapView
    func centerMapOnLocation(location: CLLocation ){
        let region = MKCoordinateRegion(center: location.coordinate,latitudinalMeters: 1000,longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
       
    }
    
    
    
    
    
    }
// 蘋果預設的網路安全須開啟允許才能設置 API，  需在 info 增加一個 Row (右鍵彈出視窗) 名為 App Transport Security Settings 然再增加子選項 Allow Arbitrary Loads 接著 Value 設為 YES，但這不是比較好的做法，較好的作法為子選項選取 Exception 那個，但之後再說吧.
 
