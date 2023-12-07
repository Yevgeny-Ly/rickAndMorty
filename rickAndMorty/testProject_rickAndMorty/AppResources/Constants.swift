//
//  Constants.swift
//  testProject_rickAndMorty
//
//  Created by Евгений Л on 23.11.2023.
//

import Foundation

final class Constants {
    
    private init() {}

/// scale animation favotite button
    static var scale: CGFloat = 1.3
    
/// sizeFigma
    //rickAndMortyLogoImageView
    static var rickAndMortyLogoImageViewTop: CGFloat = 57
    static var rickAndMortyLogoImageViewWidth: CGFloat = 312
    static var rickAndMortyLogoImageViewHeight: CGFloat = 104
    
    //searchBar
    static var searchBarWidth: CGFloat = 312
    static var searchBarHeight: CGFloat = 56
    static var searchBarTop: CGFloat = 30
    
    //filterButton
    static var filterButtonWidth: CGFloat = 312
    static var filterButtonHeight: CGFloat = 56
    static var filterButtonTop: CGFloat = 10
    
    //collectionView MainViewController
    static var collectionViewTop: CGFloat = 40
    static var collectionViewBottom: CGFloat = -85
    
/// sizeCommon
    static var smallGapUpDownViews: CGFloat = 15
    static var averageGapUpDownViews: CGFloat = 30
    static var largeGapUpDownViews: CGFloat = 60
    
    static var smallLeftMargin: CGFloat = 15
    static var smallRightMargin: CGFloat = -15
    static var averageLeftMargin: CGFloat = 30
    static var averageRightMargin: CGFloat = -30
}
