//
//  MainViewModel.swift
//  OffsiteTest
//
//  Created by Thomas Lam on 22/4/2018.
//  Copyright © 2018 Thomas Lam. All rights reserved.
//

import RxSwift
final class MainViewModel {
    let sIsLoading: PublishSubject<Bool> = PublishSubject()
    let sError: PublishSubject<Error> = PublishSubject()
    
    private var pageNo = 0
    private let pageSize = 10
    private let disposeBag = DisposeBag()
    private var fullGrossingApp: [AppItemViewModel] = []
    private var fullFreeApp: [AppItemViewModel] = []
    private var paginatedFreeApp: [AppItemViewModel] = []
    public let vFilterGrossingApp: Variable<[AppItemViewModel]> = Variable<[AppItemViewModel]>([])
    public let vFilterFreeApp: Variable<[AppItemViewModel]> = Variable<[AppItemViewModel]>([])

    public let sGrossingAppUpdated: PublishSubject<Void> = PublishSubject<Void>()
    public let sFreeAppUpdated: PublishSubject<Void> = PublishSubject<Void>()
    private var keyword: String?
    
    public func getData() {
        let topFreeApp = APIManager.Listing.getTopNFreeApps(n: 100)
        let topGrossing = APIManager.Listing.getTopNGrossingApps(n: 10)

        Observable.zip(topGrossing, topFreeApp)
            .map { ($0.0.feed?.entry, $0.1.feed?.entry) }
            .do(onError: { (error) in
                self.sError.onNext(error)
            }, onSubscribe: {

            }, onDispose: {

            })
            .subscribe(onNext: { (grossing, free) in
                self.gotGrossingApps(entry: grossing)
                self.gotFreeApps(entry: free)
            }).disposed(by: disposeBag)
    }

    private func gotGrossingApps(entry: [Entry]?) {
        self.fullGrossingApp.removeAll()

        if let entry = entry {
            self.fullGrossingApp.append(contentsOf: entry.map { AppItemViewModel.init(entry: $0) })
            self.vFilterGrossingApp.value.append(contentsOf: fullGrossingApp)
            self.sGrossingAppUpdated.onNext(())
        }
    }

    private func gotFreeApps(entry: [Entry]?) {
        self.fullFreeApp.removeAll()

        if let entry = entry {
            self.fullFreeApp.append(contentsOf: entry.map { AppItemViewModel.init(entry: $0) })
            self.fetchPaginatedDataSource()
        }
    }
    
    func requireFetchNext(row: Int) -> Bool {
        if let query = self.keyword, !query.isEmpty {
            return false
        } else {
            return row == self.vFilterFreeApp.value.count - 1 && row != fullFreeApp.count - 1
        }
    }
    
    func fetchNextPage() {
        pageNo = pageNo + 1
        self.fetchPaginatedDataSource()
    }
    
    private func fetchPaginatedDataSource() {
        Observable.from(self.fullFreeApp)
            .take(pageNo * pageSize + pageSize)
            .takeLast(pageSize)
            .flatMap({ (appItemModel) -> Observable<(AppItemViewModel, AppDetailResponse)> in
                let detailObservable = APIManager.Detail.getAppDetails(id: appItemModel.id)
                return Observable.zip(Observable.just(appItemModel), detailObservable)
            })
            .do(onDispose: {
                self.vFilterFreeApp.value = self.paginatedFreeApp
                self.sFreeAppUpdated.onNext(())
            })
            .subscribe(onNext: { (appItemViewModel, detailResponse) in
                let result = detailResponse.results?.first
                appItemViewModel.vAppUserRating.value = result?.averageUserRating
                appItemViewModel.vAppUserCommentCount.value = result?.userRatingCount
                self.paginatedFreeApp.append(appItemViewModel)
            }).disposed(by: disposeBag)
    }
    
    func applyFilter(text: String?) {
        self.keyword = text
        guard let query = text, !query.isEmpty else {
            self.vFilterFreeApp.value = self.paginatedFreeApp
            self.vFilterGrossingApp.value = self.fullGrossingApp
            self.sFreeAppUpdated.onNext(())
            self.sGrossingAppUpdated.onNext(())
            return
        }
        
        
        var filterdFreeApp = [AppItemViewModel]()
        var filterdGrossingApp = [AppItemViewModel]()
        Observable
            .from(self.paginatedFreeApp)
            .filter({ (appItemViewModel) -> Bool in
                return appItemViewModel.containsKeyWord(text: query)
            })
            .do(onSubscribed: {
                self.vFilterFreeApp.value.removeAll()
            }, onDispose: {
                self.vFilterFreeApp.value = filterdFreeApp
                self.sFreeAppUpdated.onNext(())
            })
            .subscribe(onNext: { (appItemViewModel) in
                filterdFreeApp.append(appItemViewModel)
            })
            .disposed(by: disposeBag)
        
        Observable
            .from(self.fullGrossingApp)
            .filter({ (appItemViewModel) -> Bool in
                return appItemViewModel.containsKeyWord(text: query)
            })
            .do(onSubscribed: {
                self.vFilterGrossingApp.value.removeAll()
            }, onDispose: {
                self.vFilterGrossingApp.value = filterdGrossingApp
                self.sGrossingAppUpdated.onNext(())
            })
            .subscribe(onNext: { (appItemViewModel) in
                filterdGrossingApp.append(appItemViewModel)
            })
            .disposed(by: disposeBag)
        
        
    }


}
