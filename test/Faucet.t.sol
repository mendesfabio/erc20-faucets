// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Faucet} from "../src/Faucet.sol";
import {TestToken} from "../src/TestToken.sol";

contract FaucetTest is Test {
    Faucet public faucet;
    TestToken public token;

    function setUp() public {
        faucet = new Faucet();
    }
}
