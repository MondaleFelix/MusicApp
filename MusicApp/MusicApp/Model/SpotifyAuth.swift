//
//  SpotifyAuth.swift
//  MusicApp
//
//  Created by Mondale on 9/19/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import Foundation

struct SpotifyAuth {
    public let tokenType: String //Bearer
    public let refreshToken: String?
    public let accessToken: String
    public let expiresIn: Int
    public let scope: String
}

extension SpotifyAuth: Codable { }
