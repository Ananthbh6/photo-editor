//
//  PhotoEditor+CollectionView.swift
//  Photo Editor
//
//  Created by Ananth Bhamidipati on 28/12/17.
//  Copyright © 2017 Mohamed Hamed. All rights reserved.
//

import UIKit

extension PhotoEditorViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCollectionViewCell", for: indexPath) as! FiltersCollectionViewCell
        var filteredImage = smallImage
        if indexPath.row != 0 {
            filteredImage = createFilteredImage(filterName: filterNameList[indexPath.row], image: smallImage!)
        }
        
        cell.imageView.image = filteredImage
        cell.filterNameLabel.text = filterDisplayNameList[indexPath.row]
        updateCellFont()
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterNameList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filterIndex = indexPath.row
        if filterIndex != 0 {
            applyFilter()
        } else {
            imageView?.image = image
        }
        updateCellFont()
        scrollCollectionViewToIndex(itemIndex: indexPath.item)
    }
    
    func updateCellFont() {
        // update font of selected cell
        if let selectedCell = filtersCollectionView?.cellForItem(at: IndexPath(row: filterIndex, section: 0)) {
            let cell = selectedCell as! FiltersCollectionViewCell
            cell.filterNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        }
        
        for i in 0...filterNameList.count - 1 {
            if i != filterIndex {
                // update nonselected cell font
                if let unselectedCell = filtersCollectionView?.cellForItem(at: IndexPath(row: i, section: 0)) {
                    let cell = unselectedCell as! FiltersCollectionViewCell
                    if #available(iOS 8.2, *) {
                        cell.filterNameLabel.font = UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.thin)
                    } else {
                        // Fallback on earlier versions
                        cell.filterNameLabel.font = UIFont.systemFont(ofSize: 14.0)
                    }
                }
            }
        }
    }
    
    func scrollCollectionViewToIndex(itemIndex: Int) {
        let indexPath = IndexPath(item: itemIndex, section: 0)
        self.filtersCollectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}
