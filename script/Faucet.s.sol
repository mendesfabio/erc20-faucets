// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Faucet} from "../src/Faucet.sol";
import {TestToken} from "../src/TestToken.sol";

contract FaucetScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        Faucet faucet = new Faucet();

        TestToken dai = new TestToken("Dai Stablecoin", "DAI", 18);
        dai.mint(address(faucet), 100000 * 10 ** dai.decimals());

        TestToken usdc = new TestToken("USD Coin", "USDC", 6);
        usdc.mint(address(faucet), 100000 * 10 ** usdc.decimals());

        TestToken usdt = new TestToken("Tether USD", "USDT", 6);
        usdt.mint(address(faucet), 100000 * 10 ** usdt.decimals());

        faucet.setAmount(address(dai), 500 * 10 ** dai.decimals());
        faucet.setAmount(address(usdc), 500 * 10 ** usdc.decimals());
        faucet.setAmount(address(usdt), 500 * 10 ** usdt.decimals());

        vm.stopBroadcast();
    }
}
