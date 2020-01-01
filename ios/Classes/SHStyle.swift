//
//  Style.swift
//  MapirMapKit
//
//  Created by Alireza Asadi on 19/9/1398 AP.
//  Copyright © 1398 AP Map. All rights reserved.
//

import Mapbox

let kMapirVectorStyleURL = "https://map.ir/vector/styles/main/main_mobile_style.json"
let kMapirRasterStylrURL = Bundle(for: SHMapView.self).path(forResource: "Shiveh", ofType: "json")!

@objc public class SHStyle: MGLStyle {

    @objc public static let mapirVectorStyleURL: URL = URL(string: kMapirVectorStyleURL)!

    @objc public static let mapirRasterStyleURL: URL = URL(fileURLWithPath: kMapirRasterStylrURL)
}
