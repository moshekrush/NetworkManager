//  Created by Steven Curtis

import Foundation

public class AnyNetworkManager<U: URLSessionProtocol>: NetworkManagerProtocol {
    public let session: U
    let fetchClosure: (URL, HTTPMethod, [String : String], String?, [String : Any]?, @escaping (Result<Data, Error>) -> Void) -> ()
    let cancelClosure: ()
    
    public func cancel() {
        cancelClosure
    }
    
    
    public init<T: NetworkManagerProtocol>(manager: T) {
        fetchClosure = manager.fetch
        session = manager.session as! U
        cancelClosure = manager.cancel()
    }
    
    public convenience init() {
        let manager = NetworkManager<URLSession>(session: URLSession.shared)
        self.init(manager: manager)
    }
        
    public func fetch(url: URL, method: HTTPMethod, headers: [String : String] = [:], token: String? = nil, data: [String: Any]? = nil, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        fetchClosure(url, method, headers, token, data, completionBlock)
    }
}
