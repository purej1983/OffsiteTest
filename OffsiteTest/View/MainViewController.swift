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
import Reachability

final class MainViewController: UIViewController {
    private let vm = MainViewModel()
    private let disposeBag = DisposeBag()
    private let reachability: Reachability? = Reachability()
    private let olvLoading = OverlayLoadingView()
    private let olvText = OverlayTextView()
    @IBOutlet weak var cvGrossing: UICollectionView!
    @IBOutlet var lblNoRecordGrossing: UILabel!
    @IBOutlet var lblNoRecordFree: UILabel!
    @IBOutlet weak var tvFree: UITableView!
    @IBOutlet weak var sbFilter: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        self.bindUI()
        self.initReachability()
        self.vm.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        try? reachability?.startNotifier()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        reachability?.stopNotifier()
    }

    private func initReachability() {
        reachability?.whenReachable = { reachability in
            self.sbFilter.text = ""
            self.vm.reloadPage()
        }
        reachability?.whenUnreachable = { reachability in
            let alertView = UIAlertController.init(title: "Network is unreachable", message: "Please turn on mobile data or use Wi-Fi to access data", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    private func initUI() {
        self.cvGrossing.register(GrossingCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: GrossingCollectionViewCell.self))
        self.tvFree.register(UINib.init(nibName: String(describing: FreeAppTableViewCell.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: FreeAppTableViewCell.self))

    }

    private func bindUI() {
        self.vm.sIsLoading
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (isLoading) in
                self.toggleLoading(isLoading: isLoading)
            })
            .disposed(by: disposeBag)
        
        self.vm.sError
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (error) in
                
            })
            .disposed(by: disposeBag)
        
        
        self.vm.sFirstLoad
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (_) in
                self.sbFilter.isHidden = false
                self.tvFree.isHidden = false
                self.bindSearchBar()
            })
            .disposed(by: disposeBag)

        self.vm.sGrossingAppUpdated
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (isEmpty) in
                if !self.lblNoRecordGrossing.isDescendant(of: self.view) {
                    self.cvGrossing.addSubview(self.lblNoRecordGrossing)
                    self.lblNoRecordGrossing.snp.makeConstraints {
                        $0.width.centerX.centerY.equalToSuperview()
                    }
                }
                self.lblNoRecordGrossing.isHidden = !isEmpty
                self.cvGrossing.reloadData()
            }).disposed(by: disposeBag)

        self.vm.sFreeAppUpdated
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (isEmpty) in
                if !self.lblNoRecordFree.isDescendant(of: self.view) {
                    self.view.addSubview(self.lblNoRecordFree)
                    self.lblNoRecordFree.snp.makeConstraints {
                        $0.width.centerX.centerY.equalTo(self.tvFree)
                    }
                }
                self.lblNoRecordFree.isHidden = !isEmpty
                self.tvFree.reloadData()
            }).disposed(by: disposeBag)

        
    }
    
    private func bindSearchBar() {
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
    
    private func showLoading() {
        assert(Thread.isMainThread, "Overlay can only be shown on main thread.")
        olvLoading.show()
    }
    
    private func hideLoading(animated: Bool = true) {
        olvLoading.hide(olvLoading)
    }
    
    private func toggleLoading(isLoading: Bool) {
        assert(Thread.isMainThread, "Overlay can only be shown on main thread.")
        isLoading ? olvLoading.show() : olvLoading.hide(olvLoading)
    }
    
    private func showErrorDialog(error: Error) {
        self.hideLoading()
        self.showText(error.localizedDescription)
    }
    
    private func showText(_ text: String?) {
        if text == nil || text?.count == 0 {
            return
        }
        
        olvText.setText(text!)
        olvText.show()
        olvText.hide(after: 2)
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
        if indexPath.row % 2 == 0 {
            cell.ivAppImage.makeRoundCorner()
        } else {
            cell.ivAppImage.makeCircle()
        }
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

