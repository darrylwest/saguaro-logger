//
//  SALogManagerTests.swift
//  SaguaroLogger
//
//  Created by Darryl West on 6/9/15.
//  Copyright (c) 2015 darryl.west@raincitysoftware.com. All rights reserved.
//

import UIKit
import XCTest
import SaguaroLogger

class SALogManagerTests: XCTestCase {

    func testInstance() {
        let manager = SALogManager( domain:"TestDomain" )
        
        XCTAssertEqual(manager.domain, "TestDomain", "domain should match")
    }


}
