//
//  JSONDecodable.swift
//  JatApp-Foundation
//
//  Created by Developer on 10/31/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation

public protocol JSONDecodable {
    init?(json: JSONObject)
}
