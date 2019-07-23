//
//  ManufacturerListViewController.swift
//  ThingsOnWheels
//
//  Created by Ivan Chalov on 23/07/2019.
//  Copyright © 2019 Ivan Chalov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ManufacturerListViewController: UIViewController, UITableViewDelegate {
    private let disposeBag = DisposeBag()

    var viewModel = ManufacturerListViewModel()

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
                .modelSelected(Manufacturer.self)
                .subscribe(onNext: { [weak self] element in
                    if let viewController = self?.storyboard?.instantiateViewController(withIdentifier: "ThingOnWheelsModelListVC")  as? ThingOnWheelsModelListViewController {
                        viewController.viewModel = ThingOnWheelsModelListViewModel(with: element)
                        self?.navigationController?.pushViewController(viewController, animated: true)
                    }
                })
                .disposed(by: disposeBag)
    }

}
