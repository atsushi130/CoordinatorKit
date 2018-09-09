//
//  RoutableViewController+Configurator.swift
//  CoordinatorKit
//
//  Created by Atsushi Miyake on 2018/09/09.
//  Copyright © 2018年 Atsushi Miyake. All rights reserved.
//

import UIKit

public protocol RoutableViewController where Self: UIViewController {
    associatedtype ViewControllerConfigurator: Configurator
    associatedtype Dependency
    static func instantiate(with dependency: Dependency) -> Self
}

public extension RoutableViewController where ViewControllerConfigurator.VC == Self {
    public static func instantiate(with dependency: Dependency) -> Self {
        let className  = String(describing: self)
        let storyboard = UIStoryboard(name: className, bundle: Bundle(for: self))
        let vc = storyboard.instantiateViewController(withIdentifier: className) as! Self
        ViewControllerConfigurator.configure(with: vc, dependency: dependency)
        return vc
    }
}

public extension RoutableViewController where ViewControllerConfigurator.VC == Self, Dependency == Void {
    public static func instantiate() -> Self {
        let className  = String(describing: self)
        let storyboard = UIStoryboard(name: className, bundle: Bundle(for: self))
        let vc = storyboard.instantiateViewController(withIdentifier: className) as! Self
        ViewControllerConfigurator.configure(with: vc, dependency: ())
        return vc
    }
}

public protocol Configurator {
    associatedtype VC: RoutableViewController
    static func configure(with vc: VC, dependency: VC.Dependency)
}

public extension Configurator {
    public static func configure(with vc: VC, dependency: VC.Dependency) {}
}
