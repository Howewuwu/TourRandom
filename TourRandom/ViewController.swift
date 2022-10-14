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

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
 
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
     }
    
    
    @IBAction func webButton(_ sender: Any) {
        
    }
    
    
    @IBAction func tourButton(_ sender: Any) {
        
        let detialVC = storyboard?.instantiateViewController(withIdentifier: "detailVC")as! DetailViewController
        let btn = sender as! UIButton
        if let str = btn.titleLabel?.text{
        detialVC.cate = str
            navigationController?.pushViewController(detialVC, animated: true )
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    }

