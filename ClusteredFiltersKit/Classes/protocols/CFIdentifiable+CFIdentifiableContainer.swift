//
//  CFIdentifiable.swift
//  ClusteredFillters
//
//  Created by Pasquale Spisto on 11/01/2021.
//

import Foundation

public protocol CFIdentifiable {
    var idItem: Int { get }
    var nameItem: String{ get }
}

public protocol CFIdentifiableContainer: CFIdentifiable {
    var items: [CFIdentifiable] { get }
}
