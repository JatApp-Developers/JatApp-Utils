//
//  Codable+Extension.swift
//  JatApp-Foundation
//
//  Created by Developer on 10/16/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation

public extension Decodable {
    
    static func fromJSONData(_ data: Data, decoder: JSONDecoder = JSONDecoder(), completionHandler: ResultCompletion<Self>) {

        do {
            let decoded = try decoder.decode(Self.self, from: data)
            completionHandler(.success(decoded))
        } catch let error {
            completionHandler(.failure(error))
        }
    }
    
    static func fromJSON(_ json: [String: AnyObject], decoder: JSONDecoder = JSONDecoder(), completionHandler: ResultCompletion<Self>) {
        
        guard let data = json.prepareJSONData() else {
            let error = NSError(domain: "Cannot decode response to \(Self.self)", code: 100500, userInfo: nil)
            completionHandler(.failure(error))
            return
        }
        
        fromJSONData(data, completionHandler: completionHandler)
    }
    
    static func fromJSONData(_ data: Data, decoder: JSONDecoder = JSONDecoder()) -> Self? {
        return try? decoder.decode(Self.self, from: data)
    }
}

public extension Encodable {
    
    func toJSONData(encoder: JSONEncoder = JSONEncoder(), successHandler: (Data) -> Void, failureHandler: (Error) -> Void) {
        
        do {
            let encoded = try encoder.encode(self)
            successHandler(encoded)
        } catch let error {
            failureHandler(error)
        }
    }
    
    func toJSONData(encoder: JSONEncoder = JSONEncoder()) -> Data? {
        return try? encoder.encode(self)
    }
}
