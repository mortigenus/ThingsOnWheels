//
// Created by Ivan Chalov on 2019-07-25.
// Copyright (c) 2019 Ivan Chalov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ThingOnWheelsModelListViewController: UIViewController, UITableViewDelegate {
    private let disposeBag = DisposeBag()

    var viewModel: ThingOnWheelsModelListViewModel!

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(NamedResourceCell.self)
        tableView.rowHeight = 70

        viewModel.items.asObservable()
                .bind(to: tableView.rx.items) { (tableView, row, element) in
                    let cell: NamedResourceCell = tableView.dequeueReusableCell(forIndexPath: IndexPath(row: row, section: 0))
                    cell.viewModel = NamedResourceCellViewModel(element, row)
                    return cell
                }
                .disposed(by: disposeBag)

        let viewWillAppearObserver = rx.sentMessage(#selector(viewWillAppear)).asObservable()
        viewWillAppearObserver
                .subscribe(onNext: { [weak self] _ in
                    self?.viewModel.loadItems()
                })
                .disposed(by: disposeBag)

        tableView.rx.contentOffset
                .skipUntil(viewWillAppearObserver)
                .flatMap { [weak self] _ in
                    return self?.tableView.isNearBottomEdge() == true ? Signal.just(()) : Signal.empty()
                }
                .subscribe(onNext: { [weak self] _ in
                    self?.viewModel.loadItems()
                })
                .disposed(by: disposeBag)

        tableView.rx
                .modelSelected(ThingOnWheelsModel.self)
                .subscribe(onNext: { [weak self] element in
                    guard let `self` = self else { return }
                    let alert = UIAlertController(
                            title: "Nice choice 😁", 
                            message: self.viewModel.message(with: element),
                            preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alert, animated: true)
                })
                .disposed(by: disposeBag)
    }
    
}
