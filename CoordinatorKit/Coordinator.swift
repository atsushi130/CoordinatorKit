//
//  Coordinator.swift
//  CoordinatorKit
//
//  Created by Atsushi Miyake on 2018/09/09.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit

public protocol Coordinator {
    associatedtype Route
    weak var viewController: UIViewController? { get set }
    init()
    init(viewController: UIViewController)
    func transition(to route: Route)
}

public extension Coordinator {
    public init(viewController: UIViewController) {
        self.init()
        self.viewController = viewController
    }
}
