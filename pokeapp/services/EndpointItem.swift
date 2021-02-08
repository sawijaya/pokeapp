//
//  EndpointItem.swift
//  pokeapp
//
//  Created by Salim Wijaya on 02/02/21.
//

import Foundation
import Alamofire

protocol IEndpointType {
    // MARK: - Vars & Lets
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: Alamofire.HTTPMethod { get }
    var headers: Alamofire.HTTPHeaders? { get }
    var url: URL { get }
    var encoding: Alamofire.ParameterEncoding { get }
    var version: String { get }
    var parameters:[String:Any] { get }
}

enum EndpointItem {
    case pokemon(_ parameters:[String:Any])
    case pokemonById(_ id: Int)
    case type
    case ability
    case abilityById(_ id: Int)
    case pokemonSpeciesById(_ id: Int)
    case evolutionChainById(_ id: Int)
}

extension EndpointItem: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let baseURL = self.url
        let mutableUrlRequest = NSMutableURLRequest(url: baseURL)
        mutableUrlRequest.httpMethod = self.httpMethod.rawValue
        mutableUrlRequest.timeoutInterval = 60
        mutableUrlRequest.allHTTPHeaderFields = self.headers?.dictionary
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
        mutableUrlRequest.setValue(appVersion, forHTTPHeaderField: "x-app-version-code")
        let urlRequest: URLRequest = mutableUrlRequest.copy() as! URLRequest
        let url = try encoding.encode(urlRequest as URLRequestConvertible, with: self.parameters).urlRequest!
        print(url)
        return url
    }
}

extension EndpointItem: IEndpointType {
    // MARK: - Vars & Lets
    var baseURL: String {
        return "https://pokeapi.co/api"
    }
    
    var version: String {
        return "/v2"
    }
    
    var path: String {
        switch self {
            case .pokemon:
                return "/pokemon"
            case .pokemonById(let id):
                return "/pokemon/\(id)"
            case .type:
                return "/type"
            case .ability:
                return "/ability?limit=327"
            case .abilityById(let id):
                return "/ability/\(id)"
            case .pokemonSpeciesById(let id):
                return "/pokemon-species/\(id)"
            case .evolutionChainById(let id):
                return "/evolution-chain/\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type": "application/json"]
    }
    
    var url: URL {
        switch self {
            default:
                return URL(string: self.baseURL + self.version + self.path)!
        }
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var parameters: [String : Any] {
        switch self {
            case .pokemon(let parameters):
                return parameters
            default:
                return [:]
        }
    }
}
