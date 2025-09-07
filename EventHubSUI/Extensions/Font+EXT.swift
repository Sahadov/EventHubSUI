//
//  Font+EXT.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 07/09/2025.
//

import SwiftUI

extension Font {
    struct Airbnb {
        static func bold(size: CGFloat) -> Font {
            .custom("AirbnbCereal_W_Bd", size: size)
        }
        static func book(size: CGFloat) -> Font {
            .custom("AirbnbCereal_W_Bk", size: size)
        }
        static func black(size: CGFloat) -> Font {
            .custom("AirbnbCereal_W_BlK", size: size)
        }
        static func light(size: CGFloat) -> Font {
            .custom("AirbnbCereal_W_Lt", size: size)
        }
        static func medium(size: CGFloat) -> Font {
            .custom("AirbnbCereal_W_Md", size: size)
        }
        static func extraBold(size: CGFloat) -> Font {
            .custom("AirbnbCereal_W_XBd", size: size)
        }
    }
}

/*  HOW TO USE
    .font(.Airbnb.light(size: 20))
*/
