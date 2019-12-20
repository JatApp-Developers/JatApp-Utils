//
//  ObservationToken.swift
//  JatApp-Utils
//
//  Created by Developer on 3/20/19.
//  Copyright © 2019 JatApp. All rights reserved.
//

import Foundation

/// One way to enable observations to be removed is to use tokens
/// We can return an ObservationToken every time an observation closure is added -
/// which can then later be used to cancel the observation and remove the closure.
///
public final class ObservationToken {
	
	private let cancellationClosure: () -> Void
	
	init(cancellationClosure: @escaping () -> Void) {
		self.cancellationClosure = cancellationClosure
	}
	
	func cancel() {
		cancellationClosure()
	}
}
