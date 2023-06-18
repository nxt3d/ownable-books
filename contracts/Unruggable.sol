// SPDX-License-Identifier: MIT
pragma solidity >=0.8.19<0.9.0;

import {IUnruggable} from "./IUnruggable.sol";
import {ERC165} from "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

error CannotEdit(string key);

// In the Unruggable Protocol a contract that inherits from Unruggable is called a book.
// Books have pages which can be written to to add onchain data to any contract that inherits from Unruggable. 

contract Unruggable is Ownable(msg.sender), IUnruggable, ERC165{
 
    // A mapping to store pages of the book.
    mapping(string key => string page) public pages;

    // A mapping of edit fuses.
    mapping(string key => bool cannotEditFuse) public editFuses;

    /**
    * @dev A function to write a page to the book.
    * @param key The key of the page, e.g "Title Page".
    * @param _page The page to write, could be a URI.
    */
    function writePage(string memory key, string memory _page) public onlyOwner {

        // Check to make sure the edit fuse has not been burned.
        if (editFuses[key] == true) {
            revert CannotEdit(key);
        }

        // Write the page to the book.
        pages[key] = _page;
        
    }

    /**
    * @dev A function to burn an edit fuse.
    * @param key The key of the page, e.g "Title Page". 
    */
    function burnEditFuse(string memory key) public onlyOwner {
        editFuses[key] = true;
    }

    // interface detection standard
    function supportsInterface(bytes4 interfaceId) 
        public 
        view 
        virtual 
        override
        returns (bool) 
        {
        return  
            interfaceId == type(IUnruggable).interfaceId ||
            super.supportsInterface(interfaceId);
    }

}
