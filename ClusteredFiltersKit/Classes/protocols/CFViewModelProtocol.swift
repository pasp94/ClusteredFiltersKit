//
//  IdentifiableCollectionViewModel.swift
//  ClusteredFillters
//
//  Created by Pasquale Spisto on 11/01/2021.
//

import Foundation

protocol CFViewModelProtocol {
    
    var numberOfClusters: Int { get }
    
    var numberOfFilters: Int { get }
    
    func identifiableNameWidth(at indexPath: IndexPath) -> Float

    func bindDataCell<CELL>(cell: CELL, at indexPath: IndexPath, for collectionType: CFView.CFCollectionType) where CELL: ConfigurableCell
    
    func didSelectCluster(at indexPath: IndexPath)
    
    func didSelectFilter(at indexPath: IndexPath)
}
