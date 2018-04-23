//
//  ViewController.swift
//  OffsiteTest
//
//  Created by Thomas Lam on 21/4/2018.
//  Copyright © 2018 Thomas Lam. All rights reserved.
//

import RxSwift
import RxCocoa
import SnapKit

final class MainViewController: UIViewController {
    private let vm = MainViewModel()
    private let disposeBag = DisposeBag()
    @IBOutlet weak var cvGrossing: UICollectionView!
    @IBOutlet weak var tvFree: UITableView!
    @IBOutlet weak var sbFilter: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.bindUI()
        self.vm.getData()
    }

    private func initUI() {
        self.cvGrossing.register(GrossingCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: GrossingCollectionViewCell.self))
        self.tvFree.register(UINib.init(nibName: String(describing: FreeAppTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: FreeAppTableViewCell.self))
    }

    private func bindUI() {
        self.vm.sGrossingAppUpdated
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (v) in
                self.cvGrossing.reloadData()
            }).disposed(by: disposeBag)
        
        self.vm.sFreeAppUpdated
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (v) in
                self.tvFree.reloadData()
            }).disposed(by: disposeBag)
        
        self.sbFilter
            .rx
            .text
            .throttle(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { (query) in
                self.vm.applyFilter(text: query)
            })
            .disposed(by: disposeBag)
    }
}

extension UIStackView {

    func removeAllArrangedSubviews() {

        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }

        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))

        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vm.vFilterGrossingApp.value.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = self.vm.vFilterGrossingApp.value[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GrossingCollectionViewCell.self), for: indexPath) as! GrossingCollectionViewCell
        cell.setVM(item)
        return cell
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.vFilterFreeApp.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FreeAppTableViewCell", for: indexPath) as! FreeAppTableViewCell
        cell.setVM(vm: self.vm.vFilterFreeApp.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.vm.requireFetchNext(row: indexPath.row) {
            self.vm.fetchNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

