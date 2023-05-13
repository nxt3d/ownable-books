// SPDX-License-Identifier: MIT
pragma solidity >=0.8.19<=0.9.0;

import {IUnruggable} from "./IUnruggable.sol";
import {ENSBookResolver} from "./ENSBookResolver.sol";
import {ERC165} from "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

// In the Unruggable Protocol a contract that inherits from Unruggable is called a book.
// Books have pages which can be written to add onchain data to any contract that inherits from Unruggable. 

contract Unruggable is IUnruggable, ENSBookResolver, ERC165, Ownable{
 
    // a mapping to store pages of the book
    mapping(string key => string page) public pages;

    // a mapping of ENS Coin Types to addresses
    mapping(uint256 coinType => address _address) public ensAddresses;

    // Override the function owner() from Ownable.sol
    function owner() public view override (IUnruggable, Ownable) returns (address) {
        return super.owner();
    }

    // Add a page to the book
    function writePage(string memory key, string memory _page) public onlyOwner {
        pages[key] = _page;
    }

    // Add an ENS address to the book. 
    function addEnsAddress(uint256 coinType, address _address) public onlyOwner {
        ensAddresses[coinType] = _address;
    }

    // interface detection standard
    function supportsInterface(bytes4 interfaceId) 
        public 
        view 
        virtual 
        override  (ERC165, ENSBookResolver, IUnruggable)
        returns (bool) 
        {
        return  
            interfaceId == type(IUnruggable).interfaceId ||
            super.supportsInterface(interfaceId);
    }

}
