import XCTest
@testable import Challenge

class ChallengeTests: XCTestCase {

    override func setUp() {
        
    }
    
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
    
    func test_main_getNewItemsCount() {
        let view = MainViewController()
        let service = NewsServices()
        let presenter = MainPresenterMock(view: view, service: service)
        
        XCTAssertTrue(presenter.getNewItemsCount() == 1)
        XCTAssertEqual(presenter.getNewItemsCount(), 1)
    }
    
    func test_main_getNewItemsCountWithFilterOrderBy() {
        let view = MainViewController()
        let service = NewsServices()
        let presenter = MainPresenterMock(view: view, service: service)
        
        presenter.fetchNews()
        
        XCTAssertTrue(presenter.getNewItemsCount() == 1)
        XCTAssertEqual(presenter.getNewItemsCount(), 1)
    }
}
