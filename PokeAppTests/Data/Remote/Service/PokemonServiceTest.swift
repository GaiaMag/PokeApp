//
//  PokemonServiceTest.swift
//  PokeAppTests
//
//  Created by Gaia Magnani on 10/02/2021.
//

import XCTest
@testable import PokeApp

class PokemonServiceTest: XCTestCase {
    
    private var service: PokemonServiceProtocol?
    private var urlSession: URLSession?

    override func tearDown() {
        urlSession = nil
        service = nil
    }
    
    func testServiceSuccess() {
        
        urlSession = FakeURLSession()
        service = PokemonService(session: urlSession!)
        
        var finalResult: String?
        let expectations = self.expectation(description: "loadingData")
        self.service?.request(urlString: "url", completion: { (result: Result<[String:String], Error>) in
            switch result {
            case .success(let dict):
                finalResult = dict["key"]
            case .failure(_):
                break
            }
            expectations.fulfill()
        })
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual("value", finalResult)
    }
    
    func testServiceErrorMalformedUrl() {
        
        urlSession = FakeURLSession()
        service = PokemonService(session: urlSession!)
        
        var errorDomain: String?
        var errorCode: Int?
        let expectations = self.expectation(description: "loadingData")
        self.service?.request(urlString: "°", completion: { (result: Result<[String:String], Error>) in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                errorCode = (error as NSError).code
                errorDomain = (error as NSError).domain
                break
            }
            expectations.fulfill()
        })
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(1000, errorCode)
        XCTAssertEqual("ServiceError", errorDomain)
    }
    
    func testServiceErrorApiFailure() {
        
        urlSession = FakeURLSession(failureReason: .apiError)
        service = PokemonService(session: urlSession!)
        
        var errorDomain: String?
        var errorCode: Int?
        let expectations = self.expectation(description: "loadingData")
        self.service?.request(urlString: "url", completion: { (result: Result<[String:String], Error>) in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                errorCode = (error as NSError).code
                errorDomain = (error as NSError).domain
                break
            }
            expectations.fulfill()
        })
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(1, errorCode)
        XCTAssertEqual("domain", errorDomain)
    }
    
    func testServiceErrorMissingData() {
        
        urlSession = FakeURLSession(failureReason: .missingData)
        service = PokemonService(session: urlSession!)
        
        var errorDomain: String?
        var errorCode: Int?
        let expectations = self.expectation(description: "loadingData")
        self.service?.request(urlString: "url", completion: { (result: Result<[String:String], Error>) in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                errorCode = (error as NSError).code
                errorDomain = (error as NSError).domain
                break
            }
            expectations.fulfill()
        })
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(1001, errorCode)
        XCTAssertEqual("ServiceError", errorDomain)
    }
    
    func testServiceErrorMissingResponse() {
        
        urlSession = FakeURLSession(failureReason: .missingResponse)
        service = PokemonService(session: urlSession!)
        
        var errorDomain: String?
        var errorCode: Int?
        let expectations = self.expectation(description: "loadingData")
        self.service?.request(urlString: "url", completion: { (result: Result<[String:String], Error>) in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                errorCode = (error as NSError).code
                errorDomain = (error as NSError).domain
                break
            }
            expectations.fulfill()
        })
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(1001, errorCode)
        XCTAssertEqual("ServiceError", errorDomain)
    }
    
    func testServiceErrorDecodeFailure() {
        
        urlSession = FakeURLSession(failureReason: .decodeFailure)
        service = PokemonService(session: urlSession!)
        
        var errorDomain: String?
        var errorCode: Int?
        let expectations = self.expectation(description: "loadingData")
        self.service?.request(urlString: "url", completion: { (result: Result<[String:String], Error>) in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                errorCode = (error as NSError).code
                errorDomain = (error as NSError).domain
                break
            }
            expectations.fulfill()
        })
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(1002, errorCode)
        XCTAssertEqual("ServiceError", errorDomain)
    }
    
    
}

fileprivate class FakeURLSession: URLSession {
    let failureReason: FailureReason?
    
    init(failureReason: FailureReason?) {
        self.failureReason = failureReason
    }
    
    override init() {
        self.failureReason = nil
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return FakeURLSessionDataTask(failureReason: failureReason, completionHandler: completionHandler)
    }
}

fileprivate class FakeURLSessionDataTask: URLSessionDataTask {
    let completionHandler: (Data?, URLResponse?, Error?) -> Void
    let failureReason: FailureReason?
    
    init(failureReason: FailureReason?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.completionHandler = completionHandler
        self.failureReason = failureReason
    }
    
    override func resume() {
        if let failureReason = failureReason {
            switch failureReason {
            case .apiError:
                let error = NSError(domain: "domain", code: 1, userInfo: nil)
                self.completionHandler(nil, nil, error)
                break
            case .missingData:
                self.completionHandler(nil, URLResponse(), nil)
                break
            case .missingResponse:
                let json = ["key":"value"]
                let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
                self.completionHandler(jsonData, nil, nil)
            case .decodeFailure:
                let json = ["key":1]
                let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
                self.completionHandler(jsonData, URLResponse(), nil)
            }
            
        } else {
            let json = ["key":"value"]
            let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
            self.completionHandler(jsonData, URLResponse(), nil)
        }
    }
}

fileprivate enum FailureReason {
    case apiError
    case missingData
    case missingResponse
    case decodeFailure
}
