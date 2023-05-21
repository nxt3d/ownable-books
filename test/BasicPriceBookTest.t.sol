// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";

import {BasicPriceBook} from "contracts/BasicPriceBook.sol";
import {IUnruggable} from "contracts/IUnruggable.sol";
import {IENSBookResolver} from "contracts/IENSBookResolver.sol";
import {IERC165} from "openzeppelin-contracts/contracts/utils/introspection/IERC165.sol";
import {IBasicPriceBook} from "contracts/IBasicPriceBook.sol";

error CannotEdit(string message);

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

        // Check for the IUnruggable interface.  
        assertEq(priceBook.supportsInterface(type(IUnruggable).interfaceId), true);

        // Check for the IENSBookResolver interface.  
        assertEq(priceBook.supportsInterface(type(IENSBookResolver).interfaceId), true);

        // Check for the IBasicPriceBook interface.
        assertEq(priceBook.supportsInterface(type(IBasicPriceBook).interfaceId), true);

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
        vm.expectRevert( bytes("Ownable: caller is not the owner"));
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

    // test function addEnsAddress(uint256 coinType, address _address)
    function test_009____addEnsAddress_______________AddAnENSAddress() public {

        // add a ethereum 0x address to the renewal controller.

        priceBook.addEnsAddress(
            60,
            account2
        );

        assertEq(priceBook.ensAddresses(60), account2);

    }

    function test_010____resolve_____________________ResolveAnENSAddress() public {

        // add a ethereum 0x address to the renewal controller.

        priceBook.addEnsAddress(
            60,
            account2
        );

        assertEq(priceBook.ensAddresses(60), account2);

        // Check that the resolver can resolve the address.
        (bytes memory resolvedAddress, ) = 
            priceBook.resolve(bytes("\x06can-be\x03any\x03eth\x00"), 
                abi.encodeWithSelector(bytes4(0xf1cb7e06), bytes32(0), 60));
        // Check that the address is correct.
        assertEq(address(uint160(uint256(bytes32(resolvedAddress)))), account2);
    } 

    function test_011____resolve_____________________ResolveAnENSAddressWithoutCointype() public {

        // add a ethereum 0x address to the renewal controller.

        priceBook.addEnsAddress(
            60,
            account2
        );

        assertEq(priceBook.ensAddresses(60), account2);

        // Check that the resolver can resolve the address.
        (bytes memory resolvedAddress, ) = 
            priceBook.resolve(bytes(""), 
                abi.encodeWithSelector(bytes4(0x3b3b57de), bytes32(0), 60));
        // Check that the address is correct.
        assertEq(address(uint160(uint256(bytes32(resolvedAddress)))), account2);
    } 

    function test_012____resolve_____________________ResolveATextRecordPage() public {

        // Write a page in the renewal controller "Title Page".

        priceBook.writePage(
            "Title Page",
            "Dot Eth Five Letter Price Renewal Book"
        );

        assertEq(priceBook.pages("Title Page"), "Dot Eth Five Letter Price Renewal Book");


        // Check that the resolver can resolve the text record.
        (bytes memory resolvedTextRecord, ) = 
            priceBook.resolve(bytes(""), 
                abi.encodeWithSelector(bytes4(0x59d1d43c), bytes32(0), "Title Page"));

        // abi decode resolvedTextRecord
        (string memory textRecord) = abi.decode(resolvedTextRecord, (string));
    
        // Check that the address is correct.
        assertEq(textRecord, "Dot Eth Five Letter Price Renewal Book");

    } 

    function test_013____resolve_____________________ResolveAContentRecordPage() public {

        // Write a page in the renewal controller "Book".

        priceBook.writePage(
            "Book",
            "ipfs://bafybeigdyrzt5sfp7udm7hu76uh7y26nf3efuylqabf3oclgtqy55fbzdi"
        );

        assertEq(priceBook.pages("Book"), "ipfs://bafybeigdyrzt5sfp7udm7hu76uh7y26nf3efuylqabf3oclgtqy55fbzdi");


        // Check that the resolver can resolve the content record.
        (bytes memory resolvedContentRecord, ) = 
            priceBook.resolve(bytes(""), 
                abi.encodeWithSelector(bytes4(0xbc1c58d1), bytes32(0)));

        // abi decode resolvedTextRecord
        (string memory contentRecord) = abi.decode(resolvedContentRecord, (string));
    
        // Check that the address is correct.
        assertEq(contentRecord, "ipfs://bafybeigdyrzt5sfp7udm7hu76uh7y26nf3efuylqabf3oclgtqy55fbzdi");

    } 

}
