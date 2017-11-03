//
//  ReactantCollectionView.swift
//  Reactant
//
//  Created by Filip Dolnik on 16.02.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import UIKit

public protocol ReactantCollectionView: class, Scrollable {
    
    var collectionView: UICollectionView { get }
    #if os(iOS)
    var refreshControl: UIRefreshControl? { get }
    #endif
    var emptyLabel: UILabel  { get }
    var loadingIndicator: UIActivityIndicatorView { get }
}

extension ReactantCollectionView {
    
    public func scrollToTop(animated: Bool) {
        collectionView.scrollToTop(animated: animated)
    }
}
