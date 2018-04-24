//
//  APIManagerExtension.swift
//  OffsiteTest
//
//  Created by Thomas Lam on 21/4/2018.
//  Copyright © 2018 Thomas Lam. All rights reserved.
//

import RxSwift

extension APIManager {
    public struct Listing {
        public static func getTopNFreeApps(n: Int) -> Observable<AppListingResponse> {
            return APIManager.shared.request(String.init(format: APIList.topNFreeApp, n), param: nil, response: AppListingResponse.self)
        }

        public static func getTopNGrossingApps(n: Int) -> Observable<AppListingResponse> {
            return APIManager.shared.request(String.init(format: APIList.topNGrossingApp, n), param: nil, response: AppListingResponse.self)
        }
    }

    public struct Detail {
        public static func getAppDetails(id: String) -> Observable<AppDetailResponse> {
            return APIManager.shared.request(String.init(format: APIList.appDetail, id), param: nil, response: AppDetailResponse.self)
        }
    }
}
