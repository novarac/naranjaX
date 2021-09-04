import XCTest
@testable import Challenge

class ChallengeTestsEndToEnd: XCTestCase {

    func test_request_makeAPICallFetchNews() {
        let sut = NewsServices()
        let exp = expectation(description: "Network Client Expectation fetchNews")
        
        let fieldsString = "starRating,headline,thumbnail,short-url"
        let escapedFieldsString = fieldsString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        let filtersRequest = SearchNewFiltersRequest(query: "space",
                                                     startIndex: 1,
                                                     pageSize: 10,
                                                     page: 1,
                                                     format: "json",
                                                     fromDate: "2021-01-01",
                                                     showTags: "contributor",
                                                     showFields: escapedFieldsString,
                                                     orderBy: TypeFilterOrderBy.relevance.rawValue,
                                                     tag: "film/film,tone/reviews")
        
        sut.fetchNews(params: filtersRequest) { _, _ in
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 4)
    }

    func test_request_makeAPICallFetchNewItem() {
        let sut = NewsServices()
        let exp = expectation(description: "Network Client Expectation fetchNewItem")
        
        let filtersRequest = SearchNewFiltersRequest(showFields: "all")
        
        sut.fetchNewByURL(url: "https://content.guardianapis.com/film/2021/mar/29/selfie-review-gallic-slaves-to-the-algorithm", params: filtersRequest) { _, _ in

            exp.fulfill()
        }

        wait(for: [exp], timeout: 4)
    }
}
