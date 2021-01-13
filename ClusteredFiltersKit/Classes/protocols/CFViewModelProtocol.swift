//
//  IdentifiableCollectionViewModel.swift
//  ClusteredFillters
//
//  Created by Pasquale Spisto on 11/01/2021.
//

import Foundation

public protocol CFViewModelProtocol {
    
    var numberOfClusters: Int { get }
    
    var numberOfFilters: Int { get }
    
    func calculeteCellWidth(collectionType: CFView.CFCollectionType, at index: Int) -> CGFloat

    func bindDataCell<CELL: ConfigurableCell>(cell: CELL, at indexPath: IndexPath, for collectionType: CFView.CFCollectionType)
    
    func didSelectCluster(at indexPath: IndexPath)
    
    func didSelectFilter(at indexPath: IndexPath)
}
