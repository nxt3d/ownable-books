// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";

import {BasicPriceBook} from "contracts/BasicPriceBook.sol";
import {ENSBookResolver} from "contracts/ENSBookResolver.sol";
import {IExtendedResolver} from "contracts/IExtendedResolver.sol";
import {IENSBookResolver} from "contracts/IENSBookResolver.sol";
import {IERC165} from "openzeppelin-contracts/contracts/utils/introspection/IERC165.sol";
import {IBasicPriceBook} from "contracts/IBasicPriceBook.sol";

error CannotEdit(string message);

contract ENSBookResolverTest is Test{


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
    function test2000__________________________ENS_BOOK_RESOLVER___________________________________() public {}
    function test3000________________________________________________________________________________() public {}

    //Check to make sure the subname wrapper contract supports interface detection. 
    function test_001____supportsInterface___________SupportsCorrectInterfaces() public {

        // Check for the IExtendedResolver interface.  
        assertEq(ensBookResolver.supportsInterface(type(IExtendedResolver).interfaceId), true);

        // Check for the IENSBookResolver interface.  
        assertEq(ensBookResolver.supportsInterface(type(IENSBookResolver).interfaceId), true);

        // Check for the IERC165 interface.  
        assertEq(ensBookResolver.supportsInterface(type(IERC165).interfaceId), true);
    }

    // test function addEnsAddress(uint256 coinType, address _address)
    function test_002____addEnsAddress_______________AddAnENSAddress() public {

        // add a ethereum 0x address to the renewal controller.

        ensBookResolver.addEnsAddress(
            60,
            account2
        );

        assertEq(ensBookResolver.ensAddresses(60), account2);

    }

    function test_003____resolve_____________________ResolveAnENSAddress() public {

        // add a ethereum 0x address to the renewal controller.

        ensBookResolver.addEnsAddress(
            60,
            account2
        );

        assertEq(ensBookResolver.ensAddresses(60), account2);

        // Check that the resolver can resolve the address.
        (bytes memory resolvedAddress, ) = 
            ensBookResolver.resolve(bytes("\x06can-be\x03any\x03eth\x00"), 
                abi.encodeWithSelector(bytes4(0xf1cb7e06), bytes32(0), 60));
        // Check that the address is correct.
        assertEq(address(uint160(uint256(bytes32(resolvedAddress)))), account2);
    } 

    function test_004____resolve_____________________ResolveAnENSAddressWithoutCointype() public {

        // add a ethereum 0x address to the renewal controller.

        ensBookResolver.addEnsAddress(
            60,
            account2
        );

        assertEq(ensBookResolver.ensAddresses(60), account2);

        // Check that the resolver can resolve the address.
        (bytes memory resolvedAddress, ) = 
            ensBookResolver.resolve(bytes(""), 
                abi.encodeWithSelector(bytes4(0x3b3b57de), bytes32(0)));
        // Check that the address is correct.
        assertEq(address(uint160(uint256(bytes32(resolvedAddress)))), account2);
    } 

    function test_005____resolve_____________________ResolveATextRecordPage() public {

        // Write the "Title Page".

        priceBook.writePage(
            "Title Page",
            "Dot Eth Five Letter Price Renewal Book"
        );

        assertEq(priceBook.pages("Title Page"), "Dot Eth Five Letter Price Renewal Book");

        // Check that the resolver can resolve the text record.
        (bytes memory resolvedTextRecord, ) = 
            ensBookResolver.resolve(bytes(""), 
                abi.encodeWithSelector(bytes4(0x59d1d43c), bytes32(0), "Title Page"));

        // abi decode resolvedTextRecord
        (string memory textRecord) = abi.decode(resolvedTextRecord, (string));
    
        // Check that the address is correct.
        assertEq(textRecord, "Dot Eth Five Letter Price Renewal Book");

    } 

    function test_006____resolve_____________________ResolveAvatarTextRecord() public {

        // Write a "Cover" page for use as an ENS avatar.

        priceBook.writePage(
            "Cover",
            "avatar uri"
        );

        assertEq(priceBook.pages("Cover"), "avatar uri");

        // Check that the resolver can resolve the text record.
        (bytes memory resolvedTextRecord, ) = 
            ensBookResolver.resolve(bytes(""), 
                abi.encodeWithSelector(bytes4(0x59d1d43c), bytes32(0), "avatar"));

        // abi decode resolvedTextRecord
        (string memory textRecord) = abi.decode(resolvedTextRecord, (string));
    
        // Check that the address is correct.
        assertEq(textRecord, "avatar uri");

    } 

    function test_007____resolve_____________________ResolveAContentRecordPage() public {

        // Write a page for the content record.
        priceBook.writePage(
            "Book",
            "ipfs://bafybeigdyrzt5sfp7udm7hu76uh7y26nf3efuylqabf3oclgtqy55fbzdi"
        );

        assertEq(priceBook.pages("Book"), "ipfs://bafybeigdyrzt5sfp7udm7hu76uh7y26nf3efuylqabf3oclgtqy55fbzdi");

        // Check that the resolver can resolve the content record.
        (bytes memory resolvedContentRecord, ) = 
            ensBookResolver.resolve(bytes(""), 
                abi.encodeWithSelector(bytes4(0xbc1c58d1), bytes32(0)));

        // abi decode resolvedTextRecord
        (string memory contentRecord) = abi.decode(resolvedContentRecord, (string));
    
        // Check that the address is correct.
        assertEq(contentRecord, "ipfs://bafybeigdyrzt5sfp7udm7hu76uh7y26nf3efuylqabf3oclgtqy55fbzdi");

    } 

}
