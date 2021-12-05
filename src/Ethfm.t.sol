// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test/test.sol";
import "./Ethfm.sol";
// import "./interfaces/IETHFM.sol";
// import "./interfaces/IERC3156FlashBorrower.sol";

// contract TestFlashLender is IERC3156FlashBorrower {
//     enum Action {NORMAL, STEAL, WITHDRAW, REENTER}

//     uint256 public flashBalance;
//     address public flashToken;
//     uint256 public flashValue;
//     address public flashSender;

//     receive() external payable {}

//     function onFlashLoan(address sender, address token, uint256 value, uint256, bytes calldata data) external override returns(bytes32) {
//         address lender = msg.sender;
//         (Action action) = abi.decode(data, (Action)); // Use this to unpack arbitrary data
//         flashSender = sender;
//         flashToken = token;
//         flashValue = value;
//         if (action == Action.NORMAL) {
//             flashBalance = IETHFM(lender).balanceOf(address(this));
//         } else if (action == Action.WITHDRAW) {
//             IETHFM(lender).withdraw(value);
//             flashBalance = address(this).balance;
//             IETHFM(lender).deposit{ value: value }();
//         } else if (action == Action.STEAL) {
//             // Do nothing
//         } else if (action == Action.REENTER) {
//             bytes memory newData = abi.encode(Action.NORMAL);
//             IETHFM(lender).approve(lender, IETHFM(lender).allowance(address(this), lender) + value * 2);
//             IETHFM(lender).flashLoan(this, address(lender), value * 2, newData);
//         }
//         return keccak256("ERC3156FlashBorrower.onFlashLoan");
//     }

//     function flashLoan(address lender, uint256 value) public {
//         // Use this to pack arbitrary data to `onFlashLoan`
//         bytes memory data = abi.encode(Action.NORMAL);
//         IETHFM(lender).approve(lender, value);
//         IETHFM(lender).flashLoan(this, address(lender), value, data);
//     }

//     function flashLoanAndWithdraw(address lender, uint256 value) public {
//         // Use this to pack arbitrary data to `onFlashLoan`
//         bytes memory data = abi.encode(Action.WITHDRAW);
//         IETHFM(lender).approve(lender, value);
//         IETHFM(lender).flashLoan(this, address(lender), value, data);
//     }

//     function flashLoanAndSteal(address lender, uint256 value) public {
//         // Use this to pack arbitrary data to `onFlashLoan`
//         bytes memory data = abi.encode(Action.STEAL);
//         IETHFM(lender).flashLoan(this, address(lender), value, data);
//     }

//     function flashLoanAndReenter(address lender, uint256 value) public {
//         // Use this to pack arbitrary data to `onFlashLoan`
//         bytes memory data = abi.encode(Action.REENTER);
//         IETHFM(lender).approve(lender, value);
//         IETHFM(lender).flashLoan(this, address(lender), value, data);
//     }
// }

// pragma solidity ^0.8.6;


// contract TestTransferReceiver {
//     address public token;

//     event TransferReceived(address token, address sender, uint256 value, bytes data);
//     event ApprovalReceived(address token, address spender, uint256 value, bytes data);

//     function onTokenTransfer(address sender, uint value, bytes calldata data) external returns(bool) {
//         emit TransferReceived(msg.sender, sender, value, data);
//         return true;
//     }

//     function onTokenApproval(address spender, uint value, bytes calldata data) external returns(bool) {
//         emit ApprovalReceived(msg.sender, spender, value, data);
//         return true;
//     }
// }

// interface WETH9Like {
//     function withdraw(uint) external;
//     function deposit() external payable;
//     function transfer(address, uint) external returns (bool);
//     function transferFrom(address, address, uint) external returns (bool);
// }

// interface ETHFMLike {
//     function depositTo(address) external payable;
//     function withdrawFrom(address, address, uint256) external;
// }

// contract WethConverter {
//     WETH9Like constant private weth9 = WETH9Like(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2); // ETH wrapper contract v9
//     ETHFMLike constant private ETHFM = ETHFMLike(0xf4BB2e28688e89fCcE3c0580D37d36A7672E8A9F);
    
//     receive() external payable {}

//     function weth9ToETHFM(address account, uint256 value) external payable {
//         weth9.transferFrom(account, address(this), value);
//         weth9.withdraw(value);
//         ETHFM.depositTo{value: value + msg.value}(account);
//     }

//     function ETHFMToWeth9(address account, uint256 value) external payable {
//         ETHFM.withdrawFrom(account, address(this), value);
//         uint256 combined = value + msg.value;
//         weth9.deposit{value: combined}();
//         weth9.transfer(account, combined);
//     }
// }

contract EthfmTest is DSTest {
    ETHFM ethfm;

    function setUp() public {
        ethfm = new ETHFM();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
