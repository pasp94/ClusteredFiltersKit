//
//  ModelsExample.swift
//  ClusteredFiltersKit_Example
//
//  Created by Pasquale Spisto on 13/01/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import ClusteredFiltersKit

struct Filter {
    var name: String
    var id: Int
}

extension Filter: CFIdentifiable{
    var idItem: Int {
        return self.id
    }
    
    var nameItem: String {
        return self.name
    }
}

extension Filter {
    public static func getFakefilters() -> [Filter] {
        return [
            Filter(name: "Prova1", id: 1),
            Filter(name: "Prova2", id: 2),
            Filter(name: "Testo lungo per filtri", id: 10),
            Filter(name: "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww", id: 10),
            Filter(name: "Prova3", id: 3),
            Filter(name: "Prova4", id: 4),
            Filter(name: "Prova5", id: 5),
            Filter(name: "Prova6", id: 6)
        ]
    }
}


struct Cluster {
    var name: String
    var id: Int
    var filters: [Filter]
}

extension Cluster: CFIdentifiableContainer {
    var items: [CFIdentifiable] {
        return filters
    }
    
    var idItem: Int {
        return id
    }
    
    var nameItem: String {
        return name
    }
}

extension Cluster {
    public static func getFakeClusters() -> [Cluster] {
        return [
            Cluster(name: "Prova1", id: 1, filters: Filter.getFakefilters()),
            Cluster(name: "Prova2", id: 2, filters: Filter.getFakefilters()),
            Cluster(name: "Testo lungo per filtri", id: 10, filters: Filter.getFakefilters()),
            Cluster(name: "wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww", id: 10, filters: Filter.getFakefilters()),
            Cluster(name: "Prova3", id: 3, filters: Filter.getFakefilters()),
            Cluster(name: "Prova4", id: 4, filters: Filter.getFakefilters()),
            Cluster(name: "Prova5", id: 5, filters: Filter.getFakefilters()),
            Cluster(name: "Prova6", id: 6, filters: Filter.getFakefilters())
        ]
    }
}
