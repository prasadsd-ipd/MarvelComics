//
//  ViewControllerTests.swift
//  MarvelComicsTests
//
//  Created by Imgadmin on 02/03/22.
//

import XCTest
@testable import MarvelComics

class ViewControllerTests: XCTestCase {
    var viewControllerTests : ViewController!
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewModel = ComicViewModel(with: NetworkManager())

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewControllerTests = storyboard.instantiateInitialViewController()
        //This enable the Viewcontroller to present alerts which be tested.
        //Ignoring the warning as multiple scenes are not supported.
        UIApplication.shared.keyWindow?.rootViewController = viewControllerTests
        viewControllerTests.viewModel = viewModel
        viewControllerTests.loadView()
        viewControllerTests.viewDidLoad()
        
        //Loading data from stub
        let data = loadStub(name: "ResponseTestData", extension: "json")
        let decoder = JSONDecoder()
        let comics = try! decoder.decode(IssuesResponse.self, from: data)
        viewControllerTests.viewModel?.comicsList = comics.results
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewControllerTests = nil
    }
    
    //Testing TableView & Delegate methods
    func testViewHasTableView() {
        XCTAssertNotNil(viewControllerTests.comicsTableView)
    }
    
    func testTableViewHasDelegate() {
            XCTAssertNotNil(viewControllerTests.comicsTableView.delegate)
        }

    func testTableViewHasDataSource() {
            XCTAssertNotNil(viewControllerTests.comicsTableView.dataSource)
        }

    func testTableViewConformsToTableViewDataSourceProtocol() {
            XCTAssertTrue(viewControllerTests.conforms(to: UITableViewDataSource.self))
            XCTAssertTrue(viewControllerTests.responds(to: #selector(viewControllerTests.tableView(_:numberOfRowsInSection:))))
            XCTAssertTrue(viewControllerTests.responds(to: #selector(viewControllerTests.tableView(_:cellForRowAt:))))
        }

    func testTableViewCellHasReuseIdentifier() {
            let cell = viewControllerTests.tableView(viewControllerTests.comicsTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? ComicTableViewCell
            let actualReuseIdentifer = cell?.reuseIdentifier
            let expectedReuseIdentifier = "ComicTableViewCell"
            XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
        }

    func testNumberofRowInTableView() {
        
        let numberOfRow = viewControllerTests?.tableView((viewControllerTests?.comicsTableView)!, numberOfRowsInSection: 0)
          XCTAssertEqual(numberOfRow, 33, "Number of rows in tableview should match with thirty three")

       }
    
    func testTableCellForRowAtIndexPath() {
        
        let cell = viewControllerTests.tableView(viewControllerTests.comicsTableView, cellForRowAt: IndexPath(row: 9, section: 0)) as? ComicTableViewCell
        XCTAssertEqual(cell?.comicTitle.text, "Neuronne")
        XCTAssertEqual(cell?.comicAlaises.text, "Neuronn")
    }
    
    func testShowAlert() {
        viewControllerTests.showAlert(of: .noDataAvailable)
        XCTAssertTrue(viewControllerTests.presentedViewController is UIAlertController)
        XCTAssertEqual(viewControllerTests.presentedViewController?.title, "Unable to fetch data")
    }
    
    func testFetchingCompleteWithSuccess() {
        viewControllerTests.dataFetchComplete(error: nil)
    }
    
    func testFetchingCompleteWithFailure() {
        let error = NSError(domain:"", code:404, userInfo:[ NSLocalizedDescriptionKey: "Some error occurred"]) as Error
        viewControllerTests.dataFetchComplete(error: error)
    }
}
