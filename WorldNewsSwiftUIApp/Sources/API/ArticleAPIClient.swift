//
//  WorldNewsClient.swift
//  WorldNewsSwiftUIApp
//
//  Created by Oleg Sitnikov on 08.01.25.
//
import Foundation
import OpenAPIURLSession

public struct ArticleAPIClient {

    public init() {}

    func getNewsResponse(page: Int = 1) async throws  -> Operations.GetLatestNews.Output.Ok.Body.JsonPayload {

        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        let response = try await client.getLatestNews(
                query: .init(
                    q: "Apple Vision",
                    pageSize: 10,
                    page: page
                ))

        return try response.ok.body.json
    }

    typealias NewsCategoryQuery = Operations.GetTopHeadlines.Input.Query.CategoryPayload
    typealias GetTopHeadlines = Operations.GetTopHeadlines.Output.Ok.Body.JsonPayload

    func getTopHeadline(page: Int = 1,
                        pageSize: Int  = 10,
                        category: NewsCategoryQuery = .general,
                        country: String = "us",
                        isLocal: Bool,
                        withDelay: Bool,
                        onlyAPI: Bool
    ) async throws  -> GetTopHeadlines {

        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        let response = try await client.getTopHeadlines(
                query: .init(
                    local: isLocal,
                    onlyAPI: onlyAPI,
                    withDelay: false,
                    country: country,
                    category: category,
                    pageSize: pageSize,
                    page: page
                ))

        return try response.ok.body.json
    }

}

