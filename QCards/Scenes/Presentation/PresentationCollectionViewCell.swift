//
//  PresentationCollectionViewCell.swift
//  QCards
//
//  Created by Andreas Lüdemann on 17/07/2019.
//  Copyright © 2019 Andreas Lüdemann. All rights reserved.
//

import UIKit

final class PresentationCollectionViewCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 34)
        return label
    }()
    
    private var contentTextView: UITextView = {
        let contentTextView = UITextView()
        contentTextView.isEditable = false
        contentTextView.textColor = .white
        contentTextView.backgroundColor = UIColor.UIColorFromHex(hex: "#10171E")
        contentTextView.font = UIFont.systemFont(ofSize: 14)
        return contentTextView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(contentTextView)
        
        titleLabel.anchor(top: topAnchor,
                          leading: leadingAnchor,
                          bottom: nil,
                          trailing: trailingAnchor,
                          padding: .init(top: 75, left: 15, bottom: 15, right: 15))
        
        contentTextView.anchor(top: titleLabel.bottomAnchor,
                               leading: leadingAnchor,
                               bottom: bottomAnchor,
                               trailing: trailingAnchor,
                               padding: .init(top: 15, left: 15, bottom: 15, right: 15))
        
        backgroundColor = UIColor.UIColorFromHex(hex: "#10171E")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func bind(_ viewModel: CardItemViewModel) {
        self.titleLabel.text = viewModel.title
        self.contentTextView.text = viewModel.content
    }
}
