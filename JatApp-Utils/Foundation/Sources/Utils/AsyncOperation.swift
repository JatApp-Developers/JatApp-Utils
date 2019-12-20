//
//  AsyncOperation.swift
//  JatApp-Foundation
//
//  Created by Developer on 11.11.2019.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation

public class AsyncOperation: Operation {
    
    public typealias AsyncCompletionBlock = (@escaping VoidCompletion) -> Void
    
    // MARK: - Properties
    var internalAsyncCompletionBlock: AsyncCompletionBlock?
    var asyncCompletionBlock: AsyncCompletionBlock? {
        get {
            return internalAsyncCompletionBlock
        }
        set {
            guard internalAsyncCompletionBlock == nil else { return }
            internalAsyncCompletionBlock = newValue
            if isCancelled && internalExecuting {
                isExecuting = false
            } else if let asyncCompletionBlock = newValue, internalExecuting {
                asyncCompletionBlock(done)
            }
        }
    }
    
    private var internalExecuting: Bool = false
    public override var isExecuting: Bool {
        get {
            return internalExecuting
        }
        set {
            willChangeValue(forKey: "isExecuting")
            internalExecuting = newValue
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    private var internalFinished: Bool = false
    public override var isFinished: Bool {
        get {
            return internalFinished
        }
        set {
            willChangeValue(forKey: "isFinished")
            internalFinished = newValue
            didChangeValue(forKey: "isFinished")
        }
    }
    
    public override var isAsynchronous: Bool {
        return true
    }
    
    public init(asyncCompletionBlock: AsyncCompletionBlock? = nil) {
        internalAsyncCompletionBlock = asyncCompletionBlock
        super.init()
    }
    
    public override func start() {
        
        guard !isFinished else {
            return
        }
        
        guard !isCancelled else {
            done()
            return
        }
        
        isExecuting = true
        asyncCompletionBlock?(done)
    }
    
    public func run(_ completionBlock: @escaping VoidCompletion = {}) {
        self.asyncCompletionBlock = { done in
            completionBlock()
            done()
        }
    }
}

private extension AsyncOperation {
    
    func done() {
        isExecuting = false
        isFinished = true
    }
}
