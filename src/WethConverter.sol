// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2015, 2016, 2017 Dapphub
// Adapted by Ethereum Community 2021
pragma solidity ^0.8.6;

interface WETH9Like {
    function withdraw(uint) external;
    function deposit() external payable;
    function transfer(address, uint) external returns (bool);
    function transferFrom(address, address, uint) external returns (bool);
}

interface ETHFMLike {
    function depositTo(address) external payable;
    function withdrawFrom(address, address, uint256) external;
}

contract WethConverter {
    WETH9Like constant private weth9 = WETH9Like(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2); // ETH wrapper contract v9
    ETHFMLike constant private ETHFM = ETHFMLike(0xf4BB2e28688e89fCcE3c0580D37d36A7672E8A9F);
    
    receive() external payable {}

    function weth9ToETHFM(address account, uint256 value) external payable {
        weth9.transferFrom(account, address(this), value);
        weth9.withdraw(value);
        ETHFM.depositTo{value: value + msg.value}(account);
    }

    function ETHFMToWeth9(address account, uint256 value) external payable {
        ETHFM.withdrawFrom(account, address(this), value);
        uint256 combined = value + msg.value;
        weth9.deposit{value: combined}();
        weth9.transfer(account, combined);
    }
}
