//
//  File.swift
//  
//
//  Created by bahadir on 9.06.2021.
//
import Alamofire
import Foundation

public typealias Completion<T> = (Result<T, Error>) -> Void where T: Codable

public final class NetworkManager<EndpointItem: Endpoint> {
    public init() { }
    private var possibleEmptyResponseCodes: Set<Int> {
        var defaultSet = DataResponseSerializer.defaultEmptyResponseCodes
        defaultSet.insert(200)
        return defaultSet
    }
    
    public func request<T: Codable>(endpoint: EndpointItem, type: T.Type, completion: @escaping Completion<T>) {
        AF.request(endpoint.url,
                   method: endpoint.method,
                   parameters: endpoint.parameters,
                   encoding: endpoint.encoding,
                   headers: HTTPHeaders(endpoint.headers))
            .validate()
            .response(responseSerializer: DataResponseSerializer(emptyResponseCodes: possibleEmptyResponseCodes), completionHandler: { (response) in
                switch response.result {
                case .success(let data):
                    do {
                        let decodedObject = try JSONDecoder().decode(type, from: data)
                        completion(.success(decodedObject))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    if NSURLErrorTimedOut == (error as NSError).code {
                        print("Time Out Error")
                        completion(.failure(error))
                    } else {
                        print(error)
                    }
                }
            })
    }
}

