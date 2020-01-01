//
//  MapView.swift
//  MapirMapKit
//
//  Created by Alireza Asadi on 19/9/1398 AP.
//  Copyright © 1398 AP Map. All rights reserved.
//

import Mapbox

@objc(MIMapView)
public class SHMapView: MGLMapView {

    private var attribution: UILabel!

    public override init(frame: CGRect) {
        SHMapView.preInitializationSetup()

        super.init(frame: frame)
        commonInit(styleURL: SHStyle.mapirVectorStyleURL)
    }

    public override init(frame: CGRect, styleURL: URL?) {
        SHMapView.preInitializationSetup()

        super.init(frame: frame, styleURL: styleURL)
        commonInit()
    }

    required init?(coder: NSCoder) {
        SHMapView.preInitializationSetup()

        super.init(coder: coder)
        commonInit()
    }

    private static func preInitializationSetup() {
        let config = URLSessionConfiguration.default
        config.protocolClasses?.insert(SHURLProtocol.self, at: 0)
        MGLNetworkConfiguration.sharedManager.sessionConfiguration = config
    }

    private func commonInit(styleURL: URL? = nil) {

        if let styleURL = styleURL {
            self.styleURL = styleURL
        }
        
        setupNewLogo()
        setupCompass()
        setupAttribution()
        setupDefaultAnnotationImage()
    }
}

// MARK: Logo

extension SHMapView {

    private func setupNewLogo() {
        logoView.image = UIImage(namedInCurrentBundle: "mapir")
        logoView.contentMode = .scaleAspectFit

        for c in logoView.constraints {
            if c.firstAttribute == .height {
                c.constant = 37
            } else if c.firstAttribute == .width {
                c.constant = 90
            }
        }
        self.layoutIfNeeded()
    }
}

// MARK: Compass

extension SHMapView {
    private func setupCompass() {
        compassView.image = UIImage(namedInCurrentBundle: "compass")
    }
}

// MARK: Default Annotation Marker

extension SHMapView {
    private func defaultAnnotationImage() -> MGLAnnotationImage {
        var image = UIImage(namedInCurrentBundle: "mapir_default_marker")!
        image = image.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: 0, bottom: image.size.height / 2, right: 0))

        let annotationImage = MGLAnnotationImage(image: image, reuseIdentifier: "default_marker")
        return annotationImage
    }

    private func setupDefaultAnnotationImage() {
        
    }
}

// MARK: Attribution Label

let kAttributionTitle = "© Map © OpenSreetMap"

extension SHMapView {
    private func setupAttribution() {
        attributionButton.alpha = 0

        attribution = UILabel()
        attribution.text = kAttributionTitle
        attribution.font = UIFont.systemFont(ofSize: 11)
        attribution.sizeToFit()

        let containerView = UIView(frame: attribution.frame.insetBy(dx: -6, dy: -2))
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true

        let bgView = UIView(frame: containerView.bounds)
        bgView.backgroundColor = UIColor.white
        bgView.alpha = 0.6

        containerView.addSubview(bgView)
        containerView.addSubview(attribution)
        self.addSubview(containerView)

        containerView.translatesAutoresizingMaskIntoConstraints = false
        attribution.translatesAutoresizingMaskIntoConstraints = false
        var attributionConstraints: [NSLayoutConstraint] = [
            containerView.centerYAnchor.constraint(equalTo: attribution.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: attribution.centerXAnchor),

            containerView.heightAnchor.constraint(equalToConstant: containerView.frame.height),
            containerView.widthAnchor.constraint(equalToConstant: containerView.frame.width),

            containerView.leadingAnchor.constraint(equalTo: bgView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: bgView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: bgView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor)
        ]

        let containerMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

        if #available(iOS 11.0, *) {
            attributionConstraints.append(contentsOf: [
                self.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: containerMargins.right),
                self.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: containerMargins.bottom)
            ])
        } else {
            attributionConstraints.append(contentsOf: [
                self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: containerMargins.right),
                self.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: containerMargins.bottom)
            ])
        }

        attributionConstraints.append(contentsOf: [
            attribution.heightAnchor.constraint(equalToConstant: attribution.frame.height),
            attribution.widthAnchor.constraint(equalToConstant: attribution.frame.width)
        ])

        NSLayoutConstraint.activate(attributionConstraints)
    }
}
