//
//  PhotoEditor+Filters.swift
//  Photo Editor
//
//  Created by Ananth Bhamidipati on 28/12/17.
//  Copyright © 2017 Mohamed Hamed. All rights reserved.
//

import UIKit

extension PhotoEditorViewController {
    
    func applyFilter() {
        let filterName = filterNameList[filterIndex]
        if let image = self.image {
            let filteredImage = createFilteredImage(filterName: filterName, image: image)
            imageView?.image = filteredImage
        }
    }
    
    func createFilteredImage(filterName: String, image: UIImage) -> UIImage {
        // 1 - create source image
        let sourceImage = CIImage(image: image)
        
        // 2 - create filter using name
        let filter = CIFilter(name: filterName)
        filter?.setDefaults()
        
        // 3 - set source image
        filter?.setValue(sourceImage, forKey: kCIInputImageKey)
        
        // 4 - output filtered image as cgImage with dimension.
        let outputCGImage = context.createCGImage((filter?.outputImage!)!, from: (self.imageView.bounds))
        
        // 5 - convert filtered CGImage to UIImage
        let filteredImage = UIImage(cgImage: outputCGImage!)
        
        return filteredImage
    }
    
    func resizeImage(image: UIImage) -> UIImage {
        let ratio: CGFloat = 0.3
        let resizedSize = CGSize(width: Int(image.size.width * ratio), height: Int(image.size.height * ratio))
        UIGraphicsBeginImageContext(resizedSize)
        image.draw(in: CGRect(x: 0, y: 0, width: resizedSize.width, height: resizedSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage!
    }
}

