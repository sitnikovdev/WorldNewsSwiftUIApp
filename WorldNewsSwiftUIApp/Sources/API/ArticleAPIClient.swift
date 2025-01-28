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


    typealias NewsCategoryQuery = Operations.GetTopHeadlines.Input.Query.CategoryPayload
    typealias GetTopHeadlines = Operations.GetTopHeadlines.Output.Ok.Body.JsonPayload

    func getTopHeadline(query: QueryParameters,
                        category: NewsCategoryQuery = .general
    ) async throws  -> GetTopHeadlines {

        let client = Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        let response = try await client.getTopHeadlines(
                query: .init(
                    isOnline: query.isOnline,
                    withDelay: query.withDelay,
                    savedb: query.saveDb,
                    country: query.language,
                    category: category,
                    pageSize: query.pageSize,
                    page: query.page
                ))


        return try response.ok.body.json
    }

}

