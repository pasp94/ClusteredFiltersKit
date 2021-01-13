//
//  ViewController.swift
//  ClusteredFiltersKit
//
//  Created by pasp94 on 01/12/2021.
//  Copyright (c) 2021 pasp94. All rights reserved.
//

import UIKit
import ClusteredFiltersKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let customView = CFView(frame: CGRect(x: 0, y: 60, width: UIScreen.main.bounds.width, height: 38.0))
        let collectionVM = CFViewModel(items: Cluster.getFakeClusters())
        customView.setCollectionProvider(collectionVM)
        
        view.addSubview(customView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

