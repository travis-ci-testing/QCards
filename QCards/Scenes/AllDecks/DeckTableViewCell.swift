//
//  DeckTableViewCell.swift
//  QCards
//
//  Created by Andreas Lüdemann on 20/03/2019.
//  Copyright © 2019 Andreas Lüdemann. All rights reserved.
//

import UIKit

final class DeckTableViewCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        themeService.rx.bind({ $0.activeTint }, to: label.rx.textColor).disposed(by: rx.disposeBag)
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        themeService.rx.bind({ $0.activeTint }, to: label.rx.textColor).disposed(by: rx.disposeBag)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, dateLabel])
        
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        
        addSubview(stackView)
        
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                         padding: .init(top: 15, left: 20, bottom: 12, right: 0), size: .init(width: 0, height: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func bind(to viewModel: DeckItemViewModel) {
        self.titleLabel.text = viewModel.title
        
        if let date = Double(viewModel.createdAt) {
            let dateObj = Date(timeIntervalSince1970: TimeInterval(date / 1000))
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            
            self.dateLabel.text = dateFormatter.string(from: dateObj)
        }
    }
}
