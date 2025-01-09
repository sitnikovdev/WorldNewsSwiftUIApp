//
//  WorldNewsClient.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 08.01.25.
//
import Foundation
import OpenAPIURLSession

public struct WorldNewsClient {

    public init() {}

    func getNews() async throws  -> [Components.Schemas.Article] {
        var news: [Components.Schemas.Article] = []

        let apiKey = "2fc50c684ad04a7e8dcf413c0d6e20a8"

        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: apiKey)]
        )
        let response = try await client.getLatestNews()
        let newsJson = try response.ok.body.json

        news = newsJson.articles ?? []
        return news
    }


}

