//
//  File.swift
//  
//
//  Created by bahadir on 9.06.2021.
//

public protocol Endpoint {
    var baseURL: String { get }
    var baseApiVersion: String { get }
    var conjunction: String { get }
    var path: String { get }
    var key: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
    var headers: [String: String] { get }
}

public extension Endpoint {
    var headers: [String: String] { [:] }
    var parameters: [String: Any] { [:] }
    var url: String { "\(baseURL)\(baseApiVersion)\(conjunction)\(path)?api_key=\(key)" }
}
