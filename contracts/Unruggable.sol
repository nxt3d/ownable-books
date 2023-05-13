// SPDX-License-Identifier: MIT
pragma solidity >=0.8.19<=0.9.0;

import {IUnruggable} from "./IUnruggable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ERC165} from "@openzeppelin/contracts/utils/introspection/ERC165.sol";

// In the Unruggable Protocol a contract that inherits from Unruggable is called a book.
// Books have pages which can be written to add onchain data to any contract that inherits from Unruggable. 

contract Unruggable is IUnruggable, ERC165, Ownable{
 
    // a mapping to store pages of the book
    mapping(string key => string page) public pages;

    // Override the function owner() from Ownable.sol
    function owner() public view override (IUnruggable, Ownable) returns (address) {
        return super.owner();
    }

    // Add a page to the book
    function writePage(string memory key, string memory _page) public onlyOwner {
        pages[key] = _page;
    }

    // interface detection standard
    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        return  
            interfaceId == type(IUnruggable).interfaceId ||
            super.supportsInterface(interfaceId);
    }

}
