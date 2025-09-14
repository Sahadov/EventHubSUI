//
//  LocationsList.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 14.09.2025.
//

import Foundation

import Foundation

enum LocationsList: String, CaseIterable {
    case spb
    case msk
    case nsk
    case ekb
    case nnv
    case kzn
    case krd
    case sochi
    case ufa
    case krasnoyarsk
    case kev
    
    var title: String {
        switch self {
        case .spb: return "Saint Petersburg"
        case .msk: return "Moscow"
        case .nsk: return "Novosibirsk"
        case .ekb: return "Yekaterinburg"
        case .nnv: return "Nizhny Novgorod"
        case .kzn: return "Kazan"
        case .krd: return "Krasnodar"
        case .sochi: return "Sochi"
        case .ufa: return "Ufa"
        case .krasnoyarsk: return "Krasnoyarsk"
        case .kev: return "Kyiv"
        }
    }
    
    var latitude: Double {
        switch self {
        case .spb: return 59.9398
        case .msk: return 55.7569
        case .nsk: return 55.0084
        case .ekb: return 56.8389
        case .nnv: return 56.3269
        case .kzn: return 55.7903
        case .krd: return 45.0355
        case .sochi: return 43.5855
        case .ufa: return 54.7388
        case .krasnoyarsk: return 56.0150
        case .kev: return 50.4501
        }
    }
    
    var longitude: Double {
        switch self {
        case .spb: return 30.3146
        case .msk: return 37.6151
        case .nsk: return 82.9357
        case .ekb: return 60.6057
        case .nnv: return 44.0059
        case .kzn: return 49.1347
        case .krd: return 38.9750
        case .sochi: return 39.7200
        case .ufa: return 55.9721
        case .krasnoyarsk: return 92.8932
        case .kev: return 30.5234
        }
    }
}

