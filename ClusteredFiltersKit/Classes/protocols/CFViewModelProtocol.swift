//
//  IdentifiableCollectionViewModel.swift
//  ClusteredFillters
//
//  Created by Pasquale Spisto on 11/01/2021.
//

import Foundation

public protocol CFViewModelProtocol {
    
    var cfDelegate: CFDelegate? { get set }
    
    var numberOfClusters: Int { get }
    
    var numberOfFilters: Int { get }
    
    var indexForSelectedCluster: Int { get }
    
    var indexForSelectedFilter: Int { get }
    
    func calculeteCellWidth(collectionType: CFView.CFCollectionType, at index: Int) -> CGFloat
    
    func bindeFileters(completion: @escaping () -> ())

    func bindDataCell<CELL: ConfigurableCell>(cell: CELL, at indexPath: IndexPath, for collectionType: CFView.CFCollectionType)
    
    func didSelectCluster(at indexPath: IndexPath, completion: @escaping (_ showFilters: Bool) -> ())
    
    func didSelectFilter(at indexPath: IndexPath)
}
