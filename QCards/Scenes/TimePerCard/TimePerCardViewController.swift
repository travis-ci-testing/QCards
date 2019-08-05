//
//  TimePerCardViewController.swift
//  QCards
//
//  Created by Andreas Lüdemann on 04/08/2019.
//  Copyright © 2019 Andreas Lüdemann. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

class TimePerCardViewController: UITableViewController {
    
    var viewModel: TimePerCardViewModel!
    
    private let disposeBag = DisposeBag()
    private let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TimePerCardTableViewCell.self, forCellReuseIdentifier: TimePerCardTableViewCell.reuseID)
        
        setupLayout()
        setupNavigationItems()
        bindViewModel()
    }
    
    private func setupLayout() {
        tableView.backgroundColor = UIColor.UIColorFromHex(hex: "#10171E")
    }
    
    private func setupNavigationItems() {
        navigationItem.rightBarButtonItem = saveButton
        navigationItem.title = "Time per card"
    }
    
    private func bindViewModel() {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let input = TimePerCardViewModel.Input(trigger: viewWillAppear,
                                               saveTrigger: saveButton.rx.tap.asDriver(),
                                               selection: tableView.rx.modelSelected(TimePerCardCellViewModel.self).asDriver())
        
        let output = viewModel.transform(input: input)

        output.items.map { [TimeSection(items: $0)] }
            .drive(tableView!.rx.items(dataSource: createDataSource())).disposed(by: disposeBag)

        [output.save.drive()]
            .forEach({$0.disposed(by: disposeBag)})
    }
    
    private func createDataSource() -> RxTableViewSectionedReloadDataSource<TimeSection> {
        return RxTableViewSectionedReloadDataSource(
            configureCell: { _, tableView, indexPath, viewModel -> TimePerCardTableViewCell in
                let cell = tableView.dequeueReusableCell(withIdentifier: TimePerCardTableViewCell.reuseID, for: indexPath) as! TimePerCardTableViewCell
                cell.backgroundColor = UIColor.UIColorFromHex(hex: "#15202B")
                cell.selectionStyle = .none
                cell.accessoryType = .disclosureIndicator
                cell.bind(viewModel)
                return cell
        },
            canEditRowAtIndexPath: { _, _ in true }
        )
    }
}

struct TimeSection {
    var items: [TimePerCardCellViewModel]
}

extension TimeSection: SectionModelType {
    init(original: TimeSection, items: [TimePerCardCellViewModel]) {
        self = original
        self.items = items
    }
}