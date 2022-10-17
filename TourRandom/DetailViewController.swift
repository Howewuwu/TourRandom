//
//  DetailViewController.swift
//  TourRandom
//
//  Created by Howe on 2022/10/6.
//

import UIKit
import MapKit


class DetailViewController: UIViewController {
    
    var cate = ""
    var viewsArray =  [taiwanTourViews.Tourviews.views.view]()
    //@IBOutlet weak var naviTitle: UINavigationBar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textView2: UITextView!
    
    
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
    
   // self.navigationController?.topViewController?.title = "請稍等"
    
    func getData (){
        
        print("test")
        let url = URL(string: "https://gis.taiwan.net.tw/XMLReleaseALL_public/scenic_spot_C_f.json")
        
        URLSession.shared.dataTask(with: url!) {(data,reponse,error) in
            if let errorDes = error{
                print(errorDes.localizedDescription)
            }
        
            
            do {
                if let data = data {
                    let viewData = try JSONDecoder().decode(taiwanTourViews.self, from: data)
                    for view in viewData.XML_Head.Infos.Info {
                        
                        if self.cate == view.Region {
                            self.viewsArray.append(view)
                     }
                    }
                    
//                     print(self.viewsArray)
                   }
                DispatchQueue.main.async {
                    let randomNum = Int(arc4random_uniform(UInt32(self.viewsArray.count)))
                    let vi = self.viewsArray[randomNum]
                    self.navigationController?.topViewController?.title = vi.Name
                    self.textView.text = vi.Toldescribe
                    self.textView2.text = vi.Add
                    
                    let location = CLLocation(latitude: (vi.Py)!, longitude: (vi.Px)!)
                    self.centerMapOnLocation(location: location)
                    let pin = MKPointAnnotation()
                    pin.coordinate = location.coordinate
                    self.mapView.addAnnotation(pin)
                }
                
            }catch let jsonError {
                print(jsonError)
            }
            
        }.resume()
        
    }
    
    func centerMapOnLocation(location: CLLocation ){
        let region = MKCoordinateRegion(center: location.coordinate,latitudinalMeters: 1000,longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
         
    }
    
    
    
    
    
    }
// 蘋果預設的網路安全須開啟允許才能設置 API，  需在 info 增加一個 Row 名為 App Transport Security Settings 然再增加子選項 Allow Arbitrary Loads 接著 Value 設為 YES，但這不是比較好的做法，較好的作法為子選項選取 Exception 那個，但之後再說吧.
