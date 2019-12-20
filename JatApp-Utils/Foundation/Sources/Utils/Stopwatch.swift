//
//  Stopwatch.swift
//  JatApp-Utils
//
//  Created by Developer on 3/18/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation

public protocol Stopwatch {
    
    mutating func reset()
    
    var startTime: UInt64 { get }
    var nanoseconds: UInt64 { get }
    var milliseconds: TimeInterval { get }
    var seconds: TimeInterval { get }
}

public extension Stopwatch {
    var milliseconds: TimeInterval {
        return TimeInterval(nanoseconds) / TimeInterval(NSEC_PER_MSEC)
    }
    
    var seconds: TimeInterval {
        return TimeInterval(nanoseconds) / TimeInterval(NSEC_PER_SEC)
    }
}

public class DefaultStopwatch {
    
    private(set) public var startTime: UInt64
    private let numer: UInt64
    private let denom: UInt64
    let calculationFunction: () -> UInt64
    
    fileprivate init(calculationFunction: @escaping () -> UInt64) {
        var info = mach_timebase_info(numer: 0, denom: 0)
        mach_timebase_info(&info)
        numer = UInt64(info.numer)
        denom = UInt64(info.denom)
        self.calculationFunction = calculationFunction
        startTime = calculationFunction()
    }
}

extension DefaultStopwatch: Stopwatch {
    
    public func reset() {
        startTime = calculationFunction()
    }
    
    public var nanoseconds: UInt64 {
        return ((calculationFunction() - startTime) * numer) / denom
    }
}

public class AbsoluteStopwatch: DefaultStopwatch {
    
    public init() {
        super.init(calculationFunction: mach_absolute_time)
    }
}

@available(OSX 10.12, *)
public class ContinuousStopwatch: DefaultStopwatch {
    
    public init() {
        super.init(calculationFunction: mach_continuous_time)
    }
}

public class ApproximateStopwatch: DefaultStopwatch {
    
    public init() {
        super.init(calculationFunction: mach_approximate_time)
    }
}

@available(OSX 10.12, *)
public class ContinuousApproximateStopwatch: DefaultStopwatch {

    public init() {
        super.init(calculationFunction: mach_continuous_approximate_time)
    }
}
