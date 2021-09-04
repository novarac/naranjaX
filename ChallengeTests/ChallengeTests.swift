import XCTest
@testable import Challenge

class ChallengeTests: XCTestCase {

    func test_memoryLeakController() {
        var viewC: MainViewController? = MainViewController()
        var presenter: MainPresenter? = MainPresenter(view: viewC!, service: NewsServices())
        viewC?.presenter = presenter
        
        presenter = nil
        
        addTeardownBlock { [weak viewC, weak presenter] in
            XCTAssertNil(viewC)
            XCTAssertNil(viewC?.presenter)
            XCTAssertNil(presenter)
        }
    }
    
    func test_memoryLeakControllerClosureAndPresenter() {
        let viewC = MainViewController()
        let newsUserCase = NewsServices()
        let presenter: MainPresenter? = MainPresenter(view: viewC, service: newsUserCase)
        viewC.presenter = presenter
        
        presenter?.fetchNews()
        
        addTeardownBlock { [weak viewC, weak presenter] in
            XCTAssertNil(viewC)
            XCTAssertNil(presenter)
        }
    }
}
