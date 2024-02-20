// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Faucet is Ownable {

    constructor() Ownable(msg.sender) {}

    mapping (address => uint256) public amount;
    mapping (address => mapping (address => uint)) public lastDrip;

    function setAmount(address token, uint256 amount_) external onlyOwner {
        amount[token] = amount_;
    }

    function drip(address token) external {
        require(block.timestamp - lastDrip[msg.sender][address(token)] >= 1 days, "ERR_DRIP_THROTTLE");
        require(IERC20(token).balanceOf(address(this)) >= amount[token], "ERR_NEEDS_REFILL");
        lastDrip[msg.sender][address(token)] = block.timestamp;
        IERC20(token).transfer(msg.sender, amount[token]);
    }

    function drain(address token) external onlyOwner {
        IERC20(token).transfer(msg.sender, IERC20(token).balanceOf(address(this)));
    }
}