// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "../interfaces/IETHFM.sol";
import "../interfaces/IERC3156FlashBorrower.sol";


contract TestFlashLender is IERC3156FlashBorrower {
    enum Action {NORMAL, STEAL, WITHDRAW, REENTER}

    uint256 public flashBalance;
    address public flashToken;
    uint256 public flashValue;
    address public flashSender;

    receive() external payable {}

    function onFlashLoan(address sender, address token, uint256 value, uint256, bytes calldata data) external override returns(bytes32) {
        address lender = msg.sender;
        (Action action) = abi.decode(data, (Action)); // Use this to unpack arbitrary data
        flashSender = sender;
        flashToken = token;
        flashValue = value;
        if (action == Action.NORMAL) {
            flashBalance = IETHFM(lender).balanceOf(address(this));
        } else if (action == Action.WITHDRAW) {
            IETHFM(lender).withdraw(value);
            flashBalance = address(this).balance;
            IETHFM(lender).deposit{ value: value }();
        } else if (action == Action.STEAL) {
            // Do nothing
        } else if (action == Action.REENTER) {
            bytes memory newData = abi.encode(Action.NORMAL);
            IETHFM(lender).approve(lender, IETHFM(lender).allowance(address(this), lender) + value * 2);
            IETHFM(lender).flashLoan(this, address(lender), value * 2, newData);
        }
        return keccak256("ERC3156FlashBorrower.onFlashLoan");
    }

    function flashLoan(address lender, uint256 value) public {
        // Use this to pack arbitrary data to `onFlashLoan`
        bytes memory data = abi.encode(Action.NORMAL);
        IETHFM(lender).approve(lender, value);
        IETHFM(lender).flashLoan(this, address(lender), value, data);
    }

    function flashLoanAndWithdraw(address lender, uint256 value) public {
        // Use this to pack arbitrary data to `onFlashLoan`
        bytes memory data = abi.encode(Action.WITHDRAW);
        IETHFM(lender).approve(lender, value);
        IETHFM(lender).flashLoan(this, address(lender), value, data);
    }

    function flashLoanAndSteal(address lender, uint256 value) public {
        // Use this to pack arbitrary data to `onFlashLoan`
        bytes memory data = abi.encode(Action.STEAL);
        IETHFM(lender).flashLoan(this, address(lender), value, data);
    }

    function flashLoanAndReenter(address lender, uint256 value) public {
        // Use this to pack arbitrary data to `onFlashLoan`
        bytes memory data = abi.encode(Action.REENTER);
        IETHFM(lender).approve(lender, value);
        IETHFM(lender).flashLoan(this, address(lender), value, data);
    }
}