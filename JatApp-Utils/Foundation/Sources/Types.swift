//
//  Types.swift
//  JatApp-Foundation
//
//  Created by Developer on 14.11.2019.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation

public typealias JSONObject = [String: AnyObject]
public typealias ResultCompletion<T> = (Result<T, Error>) -> Void
public typealias VoidCompletion = () -> Void
public typealias Bytes = [UInt8]
