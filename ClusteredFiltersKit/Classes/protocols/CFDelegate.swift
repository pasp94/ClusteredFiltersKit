//
//  CFDelegate.swift
//  ClusteredFillters
//
//  Created by Pasquale Spisto on 12/01/2021.
//

import Foundation

public protocol CFDelegate {
    func didSelectFilter(_ filterId: Int, ofCluster clusterId: Int)
}
