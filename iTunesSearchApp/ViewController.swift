//
//  ViewController.swift
//  iTunesSearchApp
//
//  Created by Nilay Keven on 30.12.2020.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        SearchAPI.search(term: "swift").retrieve { (response: SearchResult?) in
            print(response)
        }
    
    }


}

