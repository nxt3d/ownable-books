// SPDX-License-Identifier: MIT
pragma solidity >=0.8.19<0.9.0;

import {Unruggable} from "unruggable-protocol/contracts/Unruggable.sol";
import {ENSBookResolver} from "unruggable-protocol/contracts/ENSBookResolver.sol";
import {IBasicPriceBook} from "./IBasicPriceBook.sol";

contract BasicPriceBook is IBasicPriceBook, Unruggable, ENSBookResolver {

    uint256 public unitPrice;

    constructor(uint256 _unitPrice) {
        unitPrice = _unitPrice;
    }
    
    // Set the price
    /**
    * @dev Set the price for the contract.
    * @param _unitPrice The price to set.
     */

    function setPrice(uint256 _unitPrice) public onlyOwner {
        unitPrice = _unitPrice;
    }

    /**
    * @dev Get the price for the contract.
    * @param quantity The quantity of items.
    * @return The total price of the items.
     */

    // Get the price with a quantity
    function getPrice(uint256 quantity) public view returns (uint256) {
        return unitPrice * quantity;
    }

    function supportsInterface(bytes4 interfaceId) 
        public 
        view 
        override (ENSBookResolver, Unruggable)
        returns (bool) 
        {
        return 
            interfaceId == type(IBasicPriceBook).interfaceId ||
            super.supportsInterface(interfaceId);
    }

}