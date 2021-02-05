//
//  APIManager.swift
//  pokeapp
//
//  Created by Salim Wijaya on 02/02/21.
//

import Foundation
import Alamofire

class APIManager {
    
    private var sessionManager: Session = Session.default
    private static var sharedApiManager: APIManager = {
        let apiManager = APIManager()
        return apiManager
    }()

    // MARK: - Accessors
    class func shared() -> APIManager {
        return sharedApiManager
    }
    
    // MARK: - Initialization
    private init() {}
    
    func call(type: EndpointItem, handler: @escaping (Any?, _ error:Error?)->()) {
        print(type)
        self.sessionManager.request(type).validate().responseJSON { data in
            switch data.result {
                case .success(let response):
                    handler(response, nil)
                    break
                case .failure(let _error):
                    handler(nil, _error)
                    break
            }
        }
    }
}
