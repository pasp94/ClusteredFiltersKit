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

    @IBOutlet weak var filterIdLabel: UILabel!
    @IBOutlet weak var clusterIdLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let customView = CFView(frame: CGRect(x: 0, y: 60, width: UIScreen.main.bounds.width, height: 30.0))
        let collectionVM = CFViewModel(items: Cluster.getFakeClusters())
        customView.setCollectionProvider(collectionVM)
        customView.delegate = self
        
        view.addSubview(customView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ViewController: CFDelegate {
    func didSelectFilter(_ filterId: Int, ofCluster clusterId: Int) {
        debugPrint("EXAMPLE: Change Cluster and filter: \(filterId)   cluster: \(clusterId)")
        
        DispatchQueue.main.async { [weak self] in
            
            guard let self = self else { return }
            
            self.filterIdLabel.text     = "\(filterId)"
            self.clusterIdLabel.text    = "\(clusterId)"
        }
    }
}
