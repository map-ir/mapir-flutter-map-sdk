//
//  UIImage+Extension.swift
//  mapbox_gl
//
//  Created by Alireza Asadi on 25/9/1398 AP.
//

import Foundation

extension UIImage {

    convenience init?(namedInCurrentBundle name: String, compatibleWith traitCollection: UITraitCollection? = nil) {
        let currentBundle = Bundle(for: SHMapView.self)
        self.init(named: name, in: currentBundle, compatibleWith: traitCollection)
    }
}
