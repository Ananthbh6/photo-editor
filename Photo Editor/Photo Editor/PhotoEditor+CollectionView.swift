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
        scrollCollectionViewToIndex(itemIndex: indexPath.item)
    }
    
    func scrollCollectionViewToIndex(itemIndex: Int) {
        let indexPath = IndexPath(item: itemIndex, section: 0)
        self.filtersCollectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}
