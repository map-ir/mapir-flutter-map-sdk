//
//  AccountManager.swift
//  MapirMapKit
//
//  Created by Alireza Asadi on 19/9/1398 AP.
//  Copyright © 1398 AP Map. All rights reserved.
//

import Foundation

@objc
public class SHAccountManager: NSObject {

    public static let shared = SHAccountManager()

    public lazy var apiKey: String? = {
        Bundle.main.object(forInfoDictionaryKey: "MapirAPIKey") as? String ??
        Bundle.main.object(forInfoDictionaryKey: "MAPIRAccessToken") as? String ??
        nil
    }()

    public static var apiKey: String? { return shared.apiKey }
}
