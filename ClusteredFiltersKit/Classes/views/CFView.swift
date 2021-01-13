//
//  CFView.swift
//  ClusteredFillters
//
//  Created by Pasquale Spisto on 11/01/2021.
//

import UIKit

open class CFView: UIView {

    var clusterCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionFrame = CGRect.zero
        
        let collection = UICollectionView(frame: collectionFrame, collectionViewLayout: layout)
        collection.register(CFNamedCell.self, forCellWithReuseIdentifier: String(describing: CFNamedCell.self))
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        
        return collection
    }()
    
    
    weak var filtersCollection: UICollectionView?
    
    
    var viewModel: CFViewModelProtocol?
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        
        let collectionFrame = CGRect(origin: .zero, size: frame.size)
        clusterCollection.frame = collectionFrame
        addSubview(clusterCollection)
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func setCollectionProvider(_ viewModel: CFViewModelProtocol) {
        self.viewModel = viewModel
        
        clusterCollection.dataSource = self
        clusterCollection.delegate = self
        
        clusterCollection.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
    }
    
    public func selectItem(at index: Int) {
        clusterCollection.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
        clusterCollection.selectItem(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
    
    
    private func initCollectionView(_ type: CFCollectionType = .unknown) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionFrame = CGRect.zero
        
        let collection = UICollectionView(frame: collectionFrame, collectionViewLayout: layout)
        collection.register(CFNamedCell.self, forCellWithReuseIdentifier: String(describing: CFNamedCell.self))
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        
        return collection
    }
}


extension CFView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case clusterCollection:     return viewModel?.numberOfClusters ?? 0
            
        case filtersCollection:     return viewModel?.numberOfClusters ?? 0
            
        default:
            debugPrint("WARNING: Not defined collection case!")
            return 0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CFNamedCell.self), for: indexPath) as? CFNamedCell else { return .init() }
        
        switch collectionView {
        case clusterCollection:     viewModel?.bindDataCell(cell: cell, at: indexPath, for: .clusters)
            
        case filtersCollection:     viewModel?.bindDataCell(cell: cell, at: indexPath, for: .filters)
            
        default:
            debugPrint("WARNING: Not defined collection case!")
        }
        
        return cell
    }
}


extension CFView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case clusterCollection:
            viewModel?.didSelectCluster(at: indexPath)
            
        case filtersCollection:
            viewModel?.didSelectFilter(at: indexPath)
            
        default:
            debugPrint("WARNING: Not defined collection case!")
        }
    }
}

extension CFView: UICollectionViewDelegateFlowLayout{
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var cellWidth: CGFloat = .zero
        
        switch collectionView {
        case clusterCollection:     cellWidth = viewModel?.calculeteCellWidth(collectionType: .clusters, at: indexPath.row) ?? .zero
            
        case filtersCollection:     cellWidth = viewModel?.calculeteCellWidth(collectionType: .filters, at: indexPath.row) ?? .zero
            
        default:
            debugPrint("WARNING: Not defined collection case!")
        }
        
        return CGSize(width: cellWidth, height: collectionView.bounds.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let side: CGFloat = max(25.0, 0.0)
        
        return UIEdgeInsets(top: 0.0, left: side, bottom: 0.0, right: side)
    }
    
}

extension CFView {
    public enum CFCollectionType: Int {
        case unknown = 0
        case clusters
        case filters
    }
}

