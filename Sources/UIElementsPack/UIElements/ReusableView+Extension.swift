//
//  ReusableView+Extension.swift
//  UIElements
//
//  Copyright © Jon Olivet
//

import BasicCommons
import Foundation
import UIKit

public protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

// MARK: - ReusableView
/// ReusableView default resuse identifier
public extension ReusableView where Self: UIView {
    /// default indentifier reuse
    static var defaultReuseIdentifier: String {
        String(describing: self)
    }
}

public protocol NibLoadableView: AnyObject {
    static var nibName: String { get }
}

// MARK: - loadable view via a nib
/// NibLoadableView default name
public extension NibLoadableView where Self: UIView {
    /// setup view via nib name
    static var nibName: String {
        String(describing: self)
    }
}

// MARK: - register and get cells
/// UICollectionView + Reusable Cell
public extension UICollectionView {
    /// register collection cell
    ///
    /// - Parameter _: a type
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        let name = "\(T.self)"
        register(
            UINib(
                nibName: name,
                bundle: Utils.bundle(forClass: T.classForCoder())
            ),
            forCellWithReuseIdentifier: T.defaultReuseIdentifier
        )
    }

    /// register a collection cell
    ///
    /// - Parameters:
    ///   - _: a type
    ///   - kind: kind
    func register<T: UICollectionReusableView>(
        _: T.Type,
        forSupplementaryViewOfKind kind: String
        ) where T: ReusableView {
         let name = "\(T.self)"
        register(
            UINib(
                nibName: name,
                bundle: Utils.bundle(forClass: T.classForCoder())
            ),
            forSupplementaryViewOfKind: kind,
            withReuseIdentifier: T.defaultReuseIdentifier
        )
    }

    /// resister a collection cell
    ///
    /// - Parameter _: a type
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }

    /// gets a collection cell
    ///
    /// - Parameter indexPath: index path
    /// - Returns: a cell
    func dequeueReusableCell<T: UICollectionViewCell>(
        for indexPath: IndexPath,
        isRegistered: Bool = false) -> T where T: ReusableView {
        if !isRegistered {
            register(T.self)
        }
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }

    /// Gets a cell via generic
    ///
    /// - Parameter indexPath: a cell
    /// - Returns: a cell
    func dequeueReusableCell<T: UICollectionViewCell>(
        for indexPath: IndexPath, isRegistered: Bool = false) -> T where T: ReusableView, T: NibLoadableView {
        if !isRegistered {
            register(T.self)
        }
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }

    /// Gets a cell via generic
    ///
    /// - Parameters:
    ///   - kind: type
    ///   - indexPath: indexpath
    /// - Returns: a cell
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(
        ofKind kind: String,
        for indexPath: IndexPath,
        isRegistered: Bool = false
        ) -> T where T: ReusableView {
        if !isRegistered {
            register(T.self, forSupplementaryViewOfKind: kind)
        }
        guard let cell = dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: T.defaultReuseIdentifier,
            for: indexPath
            ) as? T else {
            fatalError("Could not dequeue reusable supplementaryView with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }

    /// Gets a cell via generic
    ///
    /// - Parameter indexPath: a cell
    /// - Returns: a cell
    func cell<T: UICollectionViewCell>(
        for indexPath: IndexPath,
        isRegistered: Bool = false
        ) -> T where T: ReusableView, T: NibLoadableView {
        if !isRegistered {
            register(T.self)
        }
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }
}

/// UITableView + Reusable cell
public extension UITableView {
    /// register a tableview cell
    ///
    /// - Parameter _: a type
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        let name = "\(T.self)"
        register(
            UINib(
                nibName: name,
                bundle: Utils.bundle(forClass: T.classForCoder())
            ),
            forCellReuseIdentifier: name
        )
    }

    /// register a tableview cell
    ///
    /// - Parameter _: a type
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }

    /// get a tableview cell via generic
    ///
    /// - Parameter indexPath: indexPath
    /// - Returns: a cell
    func dequeueReusableCell<T: UITableViewCell>(
        for indexPath: IndexPath,
        isRegistered: Bool = false
        ) -> T where T: ReusableView, T: NibLoadableView {
        if !isRegistered {
            register(T.self)
        }
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }

    /// get a tableview cell via generic
    ///
    /// - Parameter indexPath: indexpath
    /// - Returns: a cell
    func dequeueReusableCell<T: UITableViewCell>(
        for indexPath: IndexPath,
        isRegistered: Bool = false) -> T where T: ReusableView {
        if !isRegistered {
            register(T.self)
        }
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }

    /// register a footer tableview
    ///
    /// - Parameter _: type
    func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(
        _: T.Type
        ) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
    }

    /// get a footer tableview
    ///
    /// - Returns: a cell
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T where T: ReusableView {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: T.defaultReuseIdentifier) as? T else {
            fatalError("Could not dequeue Reusable HeaderFooterView with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }

    /// get a tableview cell via generic
    ///
    /// - Parameter indexPath: indexpath
    /// - Returns: a cell
    func cellForRow<T: UITableViewCell>(
        for indexPath: IndexPath,
        isRegistered: Bool = false) -> T where T: ReusableView {
        if !isRegistered {
            register(T.self)
        }

        guard let cell = cellForRow(at: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }

        return cell
    }
}
