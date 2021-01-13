//
//  CFDelegate.swift
//  ClusteredFillters
//
//  Created by Pasquale Spisto on 12/01/2021.
//

import Foundation

public protocol CFDelegate {
    func cfView(_ view: CFView, didSelectFilter filterId: Int, ofCluster clusterId: Int)
}
