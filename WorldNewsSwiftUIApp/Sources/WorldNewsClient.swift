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

    func getNewsResponse(page: Int = 1) async throws  -> Operations.GetLatestNews.Output.Ok.Body.JsonPayload {

        let apiKey = "2fc50c684ad04a7e8dcf413c0d6e20a8"

        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: apiKey)]
        )
        let response = try await client.getLatestNews(
                query: .init(
                    q: "apple",
                    pageSize: 10,
                    page: page
                ))

        return try response.ok.body.json
    }


    func getTopHeadline(page: Int = 1) async throws  -> Operations.GetTopHeadlines.Output.Ok.Body.JsonPayload {

        let apiKey = "2fc50c684ad04a7e8dcf413c0d6e20a8"

        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport(),
            middlewares: [AuthenticationMiddleware(authorizationHeaderFieldValue: apiKey)]
        )
        let response = try await client.getTopHeadlines(
                query: .init(
                    country: "us",
                    pageSize: 10,
                    page: page
                ))

        return try response.ok.body.json
    }

}

