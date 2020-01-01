//
//  SHURLProtocol.swift
//  MapirMapKit
//
//  Created by Alireza Asadi on 19/9/1398 AP.
//  Copyright © 1398 AP Map. All rights reserved.
//

import Foundation

let kMapirAuthHeaderKey = "x-api-key"
let kMapirIdentifierHeaderKey = "MapIr-SDK"
let kUserAgentHeaderKey = "User-Agent"
let kMapirAPIBaseURL = "map.ir"

class SHURLProtocol: URLProtocol {

    weak var activeTask: URLSessionTask?

    static let session: URLSession = {
        let session = URLSession(configuration: .ephemeral)
        return session
    }()

    override class func canInit(with task: URLSessionTask) -> Bool {
        if let currentRequest = task.currentRequest {
            return canInit(with: currentRequest)
        }
        return false
    }

    override class func canInit(with request: URLRequest) -> Bool {
        if let regex = try? NSRegularExpression(pattern: "^([a-zA-Z0-9-]+\\.)*map.ir$", options: .caseInsensitive) {
            if let host = request.url?.host,
                regex.firstMatch(in: host,
                                 options: .anchored,
                                 range: NSRange(location: 0, length: host.count)) != nil {
                return true
            }
        }
        return false
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        var newRequest = request

        if let apiKey = SHAccountManager.apiKey {
            newRequest.setValue(apiKey, forHTTPHeaderField: kMapirAuthHeaderKey)
        }

        newRequest.setValue(sdkIdentifier, forHTTPHeaderField: kMapirIdentifierHeaderKey)
        newRequest.setValue(userAgent, forHTTPHeaderField: kUserAgentHeaderKey)

        return newRequest
    }

    override func startLoading() {
        let urlRequest = (request as NSURLRequest).mutableCopy() as! NSMutableURLRequest
        activeTask = SHURLProtocol.session.dataTask(with: urlRequest as URLRequest) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let error = error {
                self.client?.urlProtocol(self, didFailWithError: error)
            }

            if let response = response {
                self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }

            if let data = data {
                self.client?.urlProtocol(self, didLoad: data)
            }

            self.client?.urlProtocolDidFinishLoading(self)
        }

        activeTask?.resume()
    }

    override func stopLoading() {
        activeTask?.cancel()
    }
}

let userAgent: String = {
    var components: [String] = []

    if let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        components.append("\(appName)/\(version)")
    }

    let libraryBundle: Bundle? = Bundle(for: SHMapView.self)
    if let libraryName = libraryBundle?.infoDictionary?["CFBundleName"] as? String, let version = libraryBundle?.infoDictionary?["CFBundleShortVersionString"] as? String {
        components.append("\(libraryName)/\(version)")
    }

    let system: String
    #if os(OSX)
    system = "macOS"
    #elseif os(iOS)
    system = "iOS"
    #elseif os(watchOS)
    system = "watchOS"
    #elseif os(tvOS)
    system = "tvOS"
    #endif

    let chip: String
    #if arch(x86_64)
    chip = "x86_64"
    #elseif arch(arm)
    chip = "arm"
    #elseif arch(arm64)
    chip = "arm64"
    #elseif arch(i386)
    chip = "i386"
    #endif
    let systemVersion = ProcessInfo().operatingSystemVersion
    components.append("\(system)/\(systemVersion.majorVersion).\(systemVersion.minorVersion).\(systemVersion.patchVersion)(\(chip))")

    return components.joined(separator: " ")
}()

let sdkIdentifier: String = {
    var components: [String] = []

    let system: String
    #if os(OSX)
    system = "macOS"
    #elseif os(iOS)
    system = "iOS"
    #elseif os(watchOS)
    system = "watchOS"
    #elseif os(tvOS)
    system = "tvOS"
    #endif

    let chip: String
    #if arch(x86_64)
    chip = "x86_64"
    #elseif arch(arm)
    chip = "arm"
    #elseif arch(arm64)
    chip = "arm64"
    #elseif arch(i386)
    chip = "i386"
    #endif
    let systemVersion = ProcessInfo().operatingSystemVersion
    components.append("\(system)/\(systemVersion.majorVersion).\(systemVersion.minorVersion).\(systemVersion.patchVersion)(\(chip))")

    let libraryBundle: Bundle? = Bundle(for: SHMapView.self)
    if let libraryName = libraryBundle?.infoDictionary?["CFBundleName"] as? String, let version = libraryBundle?.infoDictionary?["CFBundleShortVersionString"] as? String {
        components.append("\(libraryName)(MapirFlutter)/\(version)")
    }

    if let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String ?? Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        components.append("\(appName)/\(version)")
    }

    return components.joined(separator: "-")
}()

