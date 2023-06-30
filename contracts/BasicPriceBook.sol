// SPDX-License-Identifier: MIT
pragma solidity >=0.8.19<0.9.0;

import {OwnableBook} from "contracts/OwnableBook.sol";
import {IBasicPriceBook} from "./IBasicPriceBook.sol";

contract BasicPriceBook is IBasicPriceBook, OwnableBook {

    uint256 public unitPrice;

    constructor(uint256 _unitPrice) {
        unitPrice = _unitPrice;
    }
    
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

    function getPrice(uint256 quantity) public view returns (uint256) {
        return unitPrice * quantity;
    }

    function supportsInterface(bytes4 interfaceId) 
        public 
        view 
        override 
        returns (bool) 
        {
        return 
            interfaceId == type(IBasicPriceBook).interfaceId ||
            super.supportsInterface(interfaceId);
    }

}