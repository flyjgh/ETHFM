// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test/test.sol";

import "./Ethfm.sol";

contract EthfmTest is DSTest {
    ETHFM ethfm;

    function setUp() public {
        ethfm = new Ethfm();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
