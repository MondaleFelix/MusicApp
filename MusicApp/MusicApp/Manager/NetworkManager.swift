//
//  NetworkManager.swift
//  MusicApp
//
//  Created by Mondale on 9/14/20.
//  Copyright © 2020 Mondale. All rights reserved.
//


import Foundation
import Spartan

class NetworkManager {
    
    //make it singleton
    public static let shared = NetworkManager()
    private init() {}
    
    //properties
    static let urlSession = URLSession.shared // shared singleton session object used to run tasks. Will be useful later
    static private let baseURL = "https://accounts.spotify.com/"
    static private var parameters: [String: String] = [:]
    
    static let clientId = "f09bb189277f44ae9ad63c2ab942351f"
    static let clientSecretKey = "d90d1fdeaf5d4fc6a56985eb592c2c3b"
    static let redirectURI: String = "musicapp://"
    
    static let accessTokenKey: String = "accessTokenKey"
    static let authorizationCodeKey: String = "authorizationCodeKey"
    static let refreshTokenKey: String = "refreshTokenKey"
    
    static private let defaults = UserDefaults.standard
    
    static var totalCount: Int = Int.max
    static var codeVerifier: String = ""

    static let stringScopes = [
        "user-read-email", "user-read-private",
        "user-read-playback-state", "user-modify-playback-state", "user-read-currently-playing",
        "streaming", "app-remote-control",
        "playlist-read-collaborative", "playlist-modify-public", "playlist-read-private", "playlist-modify-private",
        "user-library-modify", "user-library-read",
        "user-top-read", "user-read-playback-position", "user-read-recently-played",
        "user-follow-read", "user-follow-modify",
    ]
    
    static var accessToken = defaults.string(forKey: accessTokenKey) {
        didSet { defaults.set(accessToken, forKey: accessTokenKey) }
    }
    static var authorizationCode = defaults.string(forKey: authorizationCodeKey) {
        didSet { defaults.set(authorizationCode, forKey: authorizationCodeKey) }
    }
    static var refreshToken = defaults.string(forKey: refreshTokenKey) {
        didSet { defaults.set(refreshToken, forKey: refreshTokenKey) }
    }

    //MARK: Static Methods
    ///fetch accessToken from Spotify
    
    static func fetchAccessToken(completion: @escaping (Result<SpotifyAuth, Error>) -> Void) {
        guard let code = authorizationCode else { return completion(.failure(ErrorMessage.missing(message: "No authorization code found."))) }
        let url = URL(string: "\(baseURL)api/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let spotifyAuthKey = "Basic \((clientId + ":" + clientSecretKey).data(using: .utf8)!.base64EncodedString())"
        request.allHTTPHeaderFields = ["Authorization": spotifyAuthKey,
                                       "Content-Type": "application/x-www-form-urlencoded"]
        var requestBodyComponents = URLComponents()
        let scopeAsString = stringScopes.joined(separator: " ") //put array to string separated by whitespace
        requestBodyComponents.queryItems = [
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: redirectURI),
            URLQueryItem(name: "code_verifier", value: codeVerifier),
            URLQueryItem(name: "scope", value: scopeAsString),
        ]
        request.httpBody = requestBodyComponents.query?.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,                              // is there data
                  let response = response as? HTTPURLResponse,  // is there HTTP response
                  (200 ..< 300) ~= response.statusCode,         // is statusCode 2XX
                  error == nil else {                           // was there no error, otherwise ...
                return completion(.failure(ErrorMessage.noData(message: "No data found")))
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase  //convert keys from snake case to camel case
            do {
                if let spotifyAuth = try? decoder.decode(SpotifyAuth.self, from: data) {
                    self.accessToken = spotifyAuth.accessToken
                    self.authorizationCode = nil
                    self.refreshToken = spotifyAuth.refreshToken
//                    Spartan.authorizationToken = spotifyAuth.accessToken
                    return completion(.success(spotifyAuth))
                }
                completion(.failure(ErrorMessage.couldNotParse(message: "Failed to decode data")))
            }
        }
        task.resume()
    }
    
    static func refreshAcessToken(completion: @escaping (Result<SpotifyAuth, Error>) -> Void) {
        guard let refreshToken = refreshToken else { return completion(.failure(ErrorMessage.missing(message: "No refresh token found."))) }
        let url = URL(string: "\(baseURL)api/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let spotifyAuthKey = "Basic \((clientId + ":" + clientSecretKey).data(using: .utf8)!.base64EncodedString())"
        request.allHTTPHeaderFields = ["Authorization": spotifyAuthKey,
                                       "Content-Type": "application/x-www-form-urlencoded"]
        var requestBodyComponents = URLComponents()
        requestBodyComponents.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken),
            URLQueryItem(name: "client_id", value: clientId),
        ]
        request.httpBody = requestBodyComponents.query?.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,                              // is there data
                  let response = response as? HTTPURLResponse,  // is there HTTP response
                  (200 ..< 300) ~= response.statusCode,         // is statusCode 2XX
                  error == nil else {                           // was there no error, otherwise ...
                return completion(.failure(ErrorMessage.noData(message: "No data found")))
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase  //convert keys from snake case to camel case
            do {
//                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
//                print(jsonResult)
                if let spotifyAuth = try? decoder.decode(SpotifyAuth.self, from: data) {
                    self.accessToken = spotifyAuth.accessToken
//                    Spartan.authorizationToken = spotifyAuth.accessToken
                    return completion(.success(spotifyAuth))
                }
                completion(.failure(ErrorMessage.couldNotParse(message: "Failed to decode data")))
            }
        }
        task.resume()
    }
    
    ///fetch user with an unexpired access token
    static func fetchUser(accessToken: String, completion: @escaping (Result<User, Error>) -> Void) {
        Spartan.authorizationToken = accessToken
        _ = Spartan.getMe(success: { (spartanUser) in
            // Do something with the user object
            print(spartanUser)
            let user = User(user: spartanUser)
//            User.setCurrent(user, writeToUserDefaults: true)
            completion(.success(user))
        }, failure: { (error) in
            if error.errorType == .unauthorized {
                print("Refresh token!")
                return
            }
            completion(.failure(error))
        })
    }
    
    
    static func fetchTopArtists(completion: @escaping (Result<[Artist], Error>) -> Void) {
        
        _ = Spartan.getMyTopArtists(limit: 50, offset: 0, timeRange: .mediumTerm, success: { (pagingObject) in
            completion(.success(pagingObject.items))

        }, failure: { (error) in
            completion(.failure(error))
        })
    }
    
    static func fetchArtistTopTracks(artistId : String, completion: @escaping (Result<[Track], Error>) -> Void ){
         _ = Spartan.getArtistsTopTracks(artistId: artistId, country: .us, success: { (tracks) in
            completion(.success(tracks))
        }, failure: { (error) in
            completion(.failure(error))
        })
    }
    

}
