// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";

import {BasicPriceBook} from "contracts/BasicPriceBook.sol";
import {ENSBookResolver} from "contracts/ENSBookResolver.sol";
import {IENSBookResolver} from "contracts/IENSBookResolver.sol";
import {IERC165} from "openzeppelin-contracts/contracts/utils/introspection/IERC165.sol";
import {IBasicPriceBook} from "contracts/IBasicPriceBook.sol";

error CannotEdit(string message);
error OwnableUnauthorizedAccount(address account);

contract BasicPriceBookTest is Test{


    address account = 0x0000000000000000000000000000000000003511;
    address account2 = 0x0000000000000000000000000000000000004612;

    BasicPriceBook priceBook;
    ENSBookResolver ensBookResolver;

    function setUp() public {

        vm.warp(1641070800); 
        vm.startPrank(account);

        // Deploy the basic price book.
        priceBook = new BasicPriceBook(5 * 1e18);

        // Deploy the ENS book resolver, and set the price book as the book to resolve to.
        ensBookResolver = new ENSBookResolver(address(priceBook));


    }


    // Create a Subheading using an empty function.
    function test1000________________________________________________________________________________() public {}
    function test2000__________________________BASIC_PRICE_BOOK_FUNCTIONS__________________________() public {}
    function test3000________________________________________________________________________________() public {}

    //Check to make sure the subname wrapper contract supports interface detection. 
    function test_001____supportsInterface___________SupportsCorrectInterfaces() public {

        // Check for the IENSBookResolver interface.  
        assertEq(ensBookResolver.supportsInterface(type(IENSBookResolver).interfaceId), true);

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

        // Get the owner of the basic price policy. 
        priceBook.transferOwnership(account2);


        vm.stopPrank();
        vm.startPrank(account2);

        priceBook.acceptOwnership();

        address contractOwner = priceBook.owner();
        assertEq(contractOwner, account2);
    }

    // Check to make sure that it is possible to renounce ownership.
    function test_004____renounceOwnership___________RenounceOwnershipIsCorrect() public {

        // Get the owner of the basic price policy. 
        priceBook.renounceOwnership();
        address contractOwner = priceBook.owner();
        assertEq(contractOwner, address(0));

        // Check that the owner can not be set again.
        vm.expectRevert( abi.encodeWithSelector(OwnableUnauthorizedAccount.selector, account));
        priceBook.transferOwnership(account2);

    }

    // Check to make sure the owner can set the price
    function test_005____setPrice____________________SetPriceIsCorrect() public {

        // Set the price. 
        priceBook.setPrice(10 * 1e18);
        uint256 price = priceBook.getPrice(1);
        assertEq(price, 10 * 1e18);
    }

    // Check to make sure anyone can get the price or 77 items.
    function test_006____getPrice____________________GetPriceIsCorrect() public {

        // Set the price. 
        priceBook.setPrice(5 * 1e18);
        // Get the price. 
        uint256 price = priceBook.getPrice(77);
        assertEq(price, 77 * 5 * 1e18);
    }


    function test_007____writePage___________________AddAPagesToTheBook() public {

        // Write a page in the renewal controller "book".

        priceBook.writePage(
            "Book",
            "https://www.test.com"
        );

        assertEq(priceBook.pages("Book"), "https://www.test.com");

    }

    function test_008____burnEditFuse________________PagesWithBurnedEditFusesCanNotBeEdited() public {

        // Write a page in the renewal controller "book".

        priceBook.writePage(
            "Book",
            "https://www.test.com"
        );

        assertEq(priceBook.pages("Book"), "https://www.test.com");

        // call burnEditFuse
        priceBook.burnEditFuse("Book");


        vm.expectRevert( abi.encodeWithSelector(CannotEdit.selector, "Book"));

        priceBook.writePage(
            "Book",
            "https://www.test.com"
        );
    }

}
