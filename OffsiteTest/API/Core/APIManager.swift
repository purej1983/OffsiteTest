//
//  APIManager.swift
//  OffsiteTest
//
//  Created by Thomas Lam on 21/4/2018.
//  Copyright © 2018 Thomas Lam. All rights reserved.
//

import Alamofire
import RxAlamofire
import RxSwift

public final class APIManager {
    var sessionMgr: SessionManager = SessionManager(configuration: .default)

    private static var domainUrl: String = ""

    public static func setDomainUrl(url: String) {
        self.domainUrl = url
    }

    public static let shared = APIManager()

    private init() {
    }



    public func request<T: Codable>(_ path: String, method: HTTPMethod = .post, param: Dictionary<String, Any>?, timeout: Double = 30, response: T.Type) -> Observable<T> {

        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeout

        sessionMgr = Alamofire.SessionManager(configuration: configuration)

        return sessionMgr
            .rx
            .request(method, path, parameters: param, encoding: Alamofire.JSONEncoding.default, headers: nil)
            .responseData()
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
        // Log Error
        .do(onError: { error in
            #if DEBUG
                //print("=================Response:\(String(describing: path))===================")
                //print(error.localizedDescription)
            #endif
            throw error
        })
            .map({ (response, data) -> T in
                let responseString = String.init(data: data, encoding: .utf8)
                #if DEBUG
                    //print("=================Response:\(String(describing: path))===================")
                    //print("=================Response:\(String(describing: responseString))===================")
                #endif
                let jsonDecoder = JSONDecoder()
                return try jsonDecoder.decode(T.self, from: data)
            })
    }

    func createError(_ code: Int, _ errorMessage: String) -> NSError {
        let domain = "Super App Error"
        let userInfo: [AnyHashable: Any] = [
            NSLocalizedDescriptionKey: errorMessage,
            NSLocalizedFailureReasonErrorKey: errorMessage
        ]
        return NSError(domain: domain, code: code, userInfo: userInfo as? [String: Any])
    }
}
