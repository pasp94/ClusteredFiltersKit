//
//  CFNamedCell.swift
//  ClusteredFillters
//
//  Created by Pasquale Spisto on 11/01/2021.
//

import UIKit

public class CFNamedCell: UICollectionViewCell {
    
    public override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: CFConstants.animationShortTime) {
                self.backgroundColor = self.isSelected ? .blue : .clear
                self.nameLabel.textColor = self.isSelected ? .white : .darkText
            }
        }
    }
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.adjustsFontSizeToFitWidth = true
        label.contentMode = .center
        label.textAlignment = .center
        
        return label
    }()
    
    public var viewModel: NamedCellViewModelProtocol?
    
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
}

extension CFNamedCell: ConfigurableCell {
    public func setViewModel<ViewModelType>(_ viewModel: ViewModelType) {
        
        self.viewModel = viewModel as? NamedCellViewModelProtocol
            
        DispatchQueue.main.async {
            self.nameLabel.text = self.viewModel?.name
        }
    }
}
