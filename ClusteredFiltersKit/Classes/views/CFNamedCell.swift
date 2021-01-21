//
//  CFNamedCell.swift
//  ClusteredFillters
//
//  Created by Pasquale Spisto on 11/01/2021.
//

import UIKit

public class CFNamedCell: UICollectionViewCell {
    
    public var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.adjustsFontSizeToFitWidth = true
        label.contentMode = .center
        label.textAlignment = .center
        
        return label
    }()
    
    public var viewModel: NamedCellViewModelProtocol?
    
    public override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: CFConstants.animationShortTime) { [weak self] in
                guard let self = self else { return }
                self.reloadCellAspect()
            }
        }
    }
    
    internal var currentStyle: CFCellStyle = .default {
        didSet {
            self.reloadCellAspect()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius  = frame.height / 2
        self.backgroundColor     = .clear
        
            
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func reloadCellAspect() {
        self.backgroundColor = isSelected ? self.currentStyle.selectionColor : .clear
        self.nameLabel.textColor = isSelected ? self.currentStyle.selectedTextColor : self.currentStyle.normalTextColor
    }
}

extension CFNamedCell: ConfigurableCell {
    
    public func setViewModel<ViewModelType>(_ viewModel: ViewModelType, cellStyle: CFCellStyle) {
        
        self.viewModel      = viewModel as? NamedCellViewModelProtocol
        self.currentStyle   = cellStyle
            
        self.nameLabel.text = self.viewModel?.name
    }
}
