//
//  CFView.swift
//  ClusteredFillters
//
//  Created by Pasquale Spisto on 11/01/2021.
//

import UIKit

@objc open class CFView: UIView {
    
    
    @objc public var selectionColor: UIColor? {
        didSet {
            let text = cellTextColor ?? CFCellStyle.default.normalTextColor
            guard let newSelection = selectionColor else {
                cellStyle = .custom(text, CFCellStyle.default.selectionColor)
                return
            }
            
            cellStyle = .custom(text, newSelection)
        }
    }
    
    @objc public var cellTextColor: UIColor? {
        didSet {
            let selection = selectionColor ?? CFCellStyle.default.selectionColor
            guard let newText = cellTextColor else {
                cellStyle = .custom(CFCellStyle.default.normalTextColor, selection)
                return
            }
            
            cellStyle = .custom(newText, selection)
        }
    }
    
    @objc public var delegate: CFDelegate? {
        didSet {
            viewModel?.cfDelegate = delegate
        }
    }
    
    
    open override var bounds: CGRect {
        didSet {
            self.reloadCollectionsFrame()
        }
    }
    
    open override var frame: CGRect {
        didSet {
            self.reloadCollectionsFrame()
        }
    }
    
    
    /// Internal proprerties
    internal var clusterCollection: UICollectionView = initCollectionView()
    
    internal var filtersCollection: UICollectionView = initCollectionView()
    
    
    
    ///Private properties
    private var viewModel: CFViewModelProtocol?
    
    private var initialSize: CGSize
    
    private var animationEnable: Bool = false
    
    private var cellStyle: CFCellStyle = .default
    
    
    public override init(frame: CGRect) {
        
        initialSize = frame.size
        
        super.init(frame: frame)
        
        self.clipsToBounds = true
        if CFConstants.runningMode == .debugUI {
            layer.borderWidth = 1.0
            layer.borderColor = UIColor.red.cgColor
        }
        
        self.addSubview(clusterCollection)
        self.addSubview(filtersCollection)
        
        ///`TO-DO:`change the initializer with filters heigt costant
        NSLayoutConstraint.activate([
            clusterCollection.topAnchor.constraint(equalTo: self.topAnchor),
            clusterCollection.leftAnchor.constraint(equalTo: self.leftAnchor),
            clusterCollection.rightAnchor.constraint(equalTo: self.rightAnchor),
            clusterCollection.heightAnchor.constraint(equalToConstant: initialSize.height),
            
            filtersCollection.topAnchor.constraint(equalTo: clusterCollection.bottomAnchor, constant: CFConstants.collectionsSpacing),
            filtersCollection.leftAnchor.constraint(equalTo: self.leftAnchor),
            filtersCollection.rightAnchor.constraint(equalTo: self.rightAnchor),
            filtersCollection.heightAnchor.constraint(equalToConstant: initialSize.height),
        
        ])
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc public func setCollectionProvider(_ viewModel: CFViewModel) {
        self.viewModel = viewModel
        
        self.viewModel?.bindeFileters { 
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                //self.animationEnable = true
                self.filtersCollection.reloadData()
                self.selectItem(at: self.viewModel?.indexForSelectedFilter ?? 0, inCollection: self.filtersCollection)
            }
        }
        
        clusterCollection.dataSource = self
        clusterCollection.delegate = self
        
        filtersCollection.dataSource = self
        filtersCollection.delegate = self
        
        selectItem(at: self.viewModel?.indexForSelectedCluster ?? 0, inCollection: clusterCollection)
    }
    
    
    internal func selectItem(at index: Int, inCollection collection: UICollectionView, animated: Bool = false) {
        let indexpath = IndexPath(row: index, section: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { [weak self] in
            guard let self = self else { return }
            
            collection.scrollToItem(at: indexpath, at: .left, animated: animated)
            collection.selectItem(at: indexpath, animated: animated, scrollPosition: .left)
            self.collectionView(collection, didSelectItemAt: indexpath)
        }
    }
    
    internal func makeFilters(isVisible: Bool, animated: Bool = true) {
        debugPrint("CFView: collection frame update!!")
        
        var newFrame = self.frame
        newFrame.size.height = isVisible ? ((initialSize.height * 2) + CFConstants.collectionsSpacing) : initialSize.height
        
        ///Code executed only when filters `Appear`
        if isVisible {
            filtersCollection.isHidden = false
        }
        
        if animated {
            UIView.animate(withDuration: CFConstants.animationShortTime, animations: {
                self.frame = newFrame
            }) { (ended) in
                if ended && !isVisible {
                    ///Code executed only when filters `Disappear`
                    self.filtersCollection.isHidden = true
                }
            }
        } else {
            self.frame = newFrame
            if !isVisible {
                filtersCollection.isHidden = false
            }
        }
    }
    
    internal static func initCollectionView(_ type: CFCollectionType = .unknown, frame: CGRect = .zero) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: frame, collectionViewLayout: layout)
        collection.register(CFNamedCell.self, forCellWithReuseIdentifier: String(describing: CFNamedCell.self))
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.isScrollEnabled = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        return collection
    }
    
    private func reloadCollectionsFrame() {
        clusterCollection.setNeedsLayout()
        filtersCollection.setNeedsLayout()
        
        self.layoutSubviews()
    }
}


extension CFView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case clusterCollection:     return viewModel?.numberOfClusters ?? 0
            
        case filtersCollection:     return viewModel?.numberOfFilters ?? 0
            
        default:
            debugPrint("WARNING: Not defined collection case!")
            return 0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CFNamedCell.self), for: indexPath) as? CFNamedCell else { return .init() }
        
        switch collectionView {
        case clusterCollection:     viewModel?.bindDataCell(cell: cell, at: indexPath, for: .clusters, style: cellStyle)
            
        case filtersCollection:     viewModel?.bindDataCell(cell: cell, at: indexPath, for: .filters, style: cellStyle)
            
        default:
            debugPrint("WARNING: Not defined collection case!")
        }
        
        return cell
    }
}


extension CFView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case clusterCollection:
            viewModel?.didSelectCluster(at: indexPath, completion: { [weak self] showFilters in
                
                guard let self = self else {return}
                self.makeFilters(isVisible: showFilters, animated: self.animationEnable)
                
            })
            
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
        
        var totalCellsWidth: CGFloat = .zero
        
        let cellsCount = self.collectionView(collectionView, numberOfItemsInSection: section)
        
        for i in 0..<cellsCount {
            let size = self.collectionView(collectionView, layout: collectionViewLayout, sizeForItemAt: IndexPath(row: i, section: section))
            totalCellsWidth += size.width
            totalCellsWidth += (i == cellsCount - 1 ? 0 : CFConstants.collectionsCellSpacing)
        }
        
        let side: CGFloat = max(CFConstants.collectionsSideInset, (collectionView.bounds.width - totalCellsWidth) / 2)
        
        return UIEdgeInsets(top: 0.0, left: side, bottom: 0.0, right: side)
    }
    
}

extension CFView {
    @objc public enum CFCollectionType: Int {
        case unknown    = 0
        case clusters
        case filters
    }
}

