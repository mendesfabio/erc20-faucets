// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Faucet} from "../src/Faucet.sol";
import {TestToken} from "../src/TestToken.sol";

contract TokensScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        address faucetAddress = 0x26bfAecAe4D5fa93eE1737ce1Ce7D53F2a0E9b2d;
        Faucet faucet = Faucet(faucetAddress);

        TestToken eurs = new TestToken("EURS", "EURS", 2);
        eurs.mint(address(faucet), 100000 * 10 ** eurs.decimals());

        TestToken beets = new TestToken("BeethovenxToken", "BEETS", 18);
        beets.mint(address(faucet), 500000 * 10 ** beets.decimals());

        TestToken wbtc = new TestToken("Wrapped BTC", "WBTC", 8);
        wbtc.mint(address(faucet), 10 * 10 ** wbtc.decimals());

        faucet.setAmount(address(eurs), 500 * 10 ** eurs.decimals());
        faucet.setAmount(address(beets), 5000 * 10 ** beets.decimals());
        faucet.setAmount(address(wbtc), 1000000);

        vm.stopBroadcast();
    }
}
