// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";

import {BasicPriceBook} from "contracts/BasicPriceBook.sol";
import {IUnruggable} from "contracts/IUnruggable.sol";
import {IERC165} from "openzeppelin-contracts/contracts/utils/introspection/IERC165.sol";


contract BasicPriceBookTest is Test{


    address account = 0x0000000000000000000000000000000000003511;
    address account2 = 0x0000000000000000000000000000000000004612;

    BasicPriceBook priceBook;

    function setUp() public {

        vm.warp(1641070800); 
        vm.startPrank(account);

        priceBook = new BasicPriceBook(5 * 1e18);


    }


    // Create a Subheading using an empty function.
    function test1000________________________________________________________________________________() public {}
    function test2000__________________________BASIC_PRICE_BOOK_FUNCTIONS__________________________() public {}
    function test3000________________________________________________________________________________() public {}

    //Check to make sure the subname wrapper contract supports interface detection. 
    function test_001____supportsInterface___________SupportsCorrectInterfaces() public {

        // Check for the IERC1155MetadataURI interface.  
        assertEq(priceBook.supportsInterface(type(IUnruggable).interfaceId), true);

        // Check for the IERC165 interface.  
        assertEq(priceBook.supportsInterface(type(IERC165).interfaceId), true);
    }

    // Check to make sure the owner of the subname is correct.
    function test_002____ownerOf_____________________OwnerIsCorrect() public {

        // Get the owner of the basic price policy 
        address contractOwner = priceBook.owner();
        assertEq(contractOwner, account);
    }

    // Check to make sure the owner of the subname is correct.
    function test_003____transferOwnership___________TransferOwnershipIsCorrect() public {

        // Get the owner of the basic price policy 
        priceBook.transferOwnership(account2);
        address contractOwner = priceBook.owner();
        assertEq(contractOwner, account2);
    }
}
