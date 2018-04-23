//
//  MainViewModel.swift
//  OffsiteTest
//
//  Created by Thomas Lam on 22/4/2018.
//  Copyright © 2018 Thomas Lam. All rights reserved.
//

import RxSwift
final class MainViewModel {
    private var pageNo = 0
    private let pageSize = 10
    private let disposeBag = DisposeBag()
    private var fullGrossingApp: [AppItemViewModel] = []
    private var fullFreeApp: [AppItemViewModel] = []
    private var paginatedFreeApp: [AppItemViewModel] = []
    private var keyword: String?
    private var isFirstLoaded = false

    public let sIsLoading: PublishSubject<Bool> = PublishSubject<Bool>()
    public let sError: PublishSubject<Error> = PublishSubject<Error>()

    public let vFilterGrossingApp: Variable<[AppItemViewModel]> = Variable<[AppItemViewModel]>([])
    public let vFilterFreeApp: Variable<[AppItemViewModel]> = Variable<[AppItemViewModel]>([])

    public let sGrossingAppUpdated: PublishSubject<Bool> = PublishSubject<Bool>()
    public let sFreeAppUpdated: PublishSubject<Bool> = PublishSubject<Bool>()
    public let sFirstLoad: PublishSubject<Void> = PublishSubject<Void>()



    public func getData() {
        let topFreeApp = APIManager.Listing.getTopNFreeApps(n: 100)
        let topGrossing = APIManager.Listing.getTopNGrossingApps(n: 10)

        Observable.zip(topGrossing, topFreeApp)
            .map { ($0.0.feed?.entry, $0.1.feed?.entry) }
            .do(onError: { (error) in
                self.sError.onNext(error)
            }, onSubscribed: {
                self.sIsLoading.onNext(true)
            }, onDispose: {
                self.sIsLoading.onNext(false)
            })
            .subscribe(onNext: { (grossing, free) in
                self.gotGrossingApps(entry: grossing)
                self.gotFreeApps(entry: free)
            }).disposed(by: disposeBag)
    }

    public func reloadPage() {
        self.isFirstLoaded = false
        self.clearData()
        self.getData()
    }
    private func clearData() {
        self.fullFreeApp.removeAll()
        self.fullGrossingApp.removeAll()
        self.paginatedFreeApp.removeAll()

    }

    private func gotGrossingApps(entry: [Entry]?) {
        self.fullGrossingApp.removeAll()

        if let entry = entry {
            self.fullGrossingApp.append(contentsOf: entry.map { AppItemViewModel.init(entry: $0) })
            self.vFilterGrossingApp.value.append(contentsOf: fullGrossingApp)
            let isEmpty = self.vFilterGrossingApp.value.count == 0
            self.sGrossingAppUpdated.onNext(isEmpty)
        } else {
            self.sGrossingAppUpdated.onNext(true)
        }
    }

    private func gotFreeApps(entry: [Entry]?) {
        self.fullFreeApp.removeAll()

        if let entry = entry {
            self.fullFreeApp.append(contentsOf: entry.map { AppItemViewModel.init(entry: $0) })
            self.fetchPaginatedDataSource()
        } else {
            self.sFreeAppUpdated.onNext(true)
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
            .do(onSubscribed: {
                self.sIsLoading.onNext(true)
            })
            .do(onDispose: {
                self.vFilterFreeApp.value = self.paginatedFreeApp
                if !self.isFirstLoaded {
                    self.isFirstLoaded = true
                    self.sFirstLoad.onNext(())
                }

                let isEmpty = self.vFilterFreeApp.value.count == 0
                self.sFreeAppUpdated.onNext(isEmpty)
                self.sIsLoading.onNext(false)

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
            let isFreeAppEmpty = self.vFilterFreeApp.value.count == 0
            let isGrossingAppEmpty = self.vFilterGrossingApp.value.count == 0
            self.sFreeAppUpdated.onNext(isFreeAppEmpty)
            self.sGrossingAppUpdated.onNext(isGrossingAppEmpty)
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
                let isEmpty = self.vFilterFreeApp.value.count == 0
                self.sFreeAppUpdated.onNext(isEmpty)
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
                let isEmpty = self.vFilterGrossingApp.value.count == 0
                self.sGrossingAppUpdated.onNext(isEmpty)
            })
            .subscribe(onNext: { (appItemViewModel) in
                filterdGrossingApp.append(appItemViewModel)
            })
            .disposed(by: disposeBag)


    }


}
