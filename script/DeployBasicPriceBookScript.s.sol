// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {BasicPriceBook} from "contracts/BasicPriceBook.sol";
import {ENSBookResolver} from "contracts/ENSBookResolver.sol";

contract DeployBasicPriceBookScript is Script {
    function setUp() public {}

    BasicPriceBook public priceBook;

    ENSBookResolver public ensBookResolver;

    function run() public {

    // ---------------- Depoy to Goerli ----------------//
    // forge script script/DeploySNW_1.s.sol --rpc-url $GOERLI_RPC_URL --broadcast --verify -vvvv

    // Goerli account
    //address account = address(0x9bDBB7a40d346b86953E311E32F7573F8989BaB3);

    // Chainlink oracle for goerli.
    //IAggregatorInterface goerli_ETH_USD_Oracle = IAggregatorInterface(address(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e));

    // ---------------- Depoy to Anvil ----------------//
    // forge script script/DeployBasicPriceBookScript.s.sol --fork-url http://localhost:8545 --private-key $PRIVATE_KEY --broadcast -vvvv 

    // Anvil first acocunt for local testing
    address account = address(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);

    //-------------------------------------------------//

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        priceBook = new BasicPriceBook(5 * 1e18); 

        // Deploy the ENS book resolver, and set the price book as the book to resolve to.
        ensBookResolver = new ENSBookResolver(address(priceBook));

        ensBookResolver.addEnsAddress(60, address(priceBook));

        priceBook.writePage("Book", "content");
        priceBook.writePage("Cover", "avatar");

        // Resolve the address of the name without using a chain ID.
        console.log("////////////////// Resolve address ///////////////////////");
        (bytes memory result, ) = ensBookResolver.resolve(bytes(""), 
            abi.encodeWithSelector(bytes4(0x3b3b57de), bytes32(0)));
        console.log("Resolved Address: %s", abi.decode(result, (address)));    

        // Resolve the address of the name
        console.log("////////////////// Resolve address with coin type 60 ///////////////////////");
        (bytes memory result1, ) = ensBookResolver.resolve(bytes(""), 
            abi.encodeWithSelector(bytes4(0xf1cb7e06), bytes32(0), uint256(60)));
        console.log("Resolved Address: %s", abi.decode(result1, (address)));    

        // Resolve the text record of the name
        console.log("////////////////// Resolve with avatar record ///////////////////////");
        (bytes memory txt1, ) = ensBookResolver.resolve(bytes(""), 
            abi.encodeWithSelector(bytes4(0x59d1d43c), bytes32(0), "avatar"));
        // log the result
        console.log("Resolved Text Record (avatar): %s", abi.decode(txt1, (string)));

        // Resolve the content record of the name
        console.log("////////////////// Resolve content record ///////////////////////");
        (bytes memory con1, ) = ensBookResolver.resolve(bytes(""), 
            abi.encodeWithSelector(bytes4(0xbc1c58d1), bytes32(0)));
        // Console log conent record.
        console.log("Resolved Content Record: %s", abi.decode(con1, (string)));

        console.log("Price Book Address: %s", address(priceBook));
        console.log("Price Book Owner: %s", priceBook.owner());
        console.log("Price Book Unit Price: %s", priceBook.unitPrice());
        console.log("Price Book Page: %s", priceBook.pages("Book"));
        console.log("EnsBookResolver Address: %s", address(ensBookResolver));

        vm.stopBroadcast();

    }
}
