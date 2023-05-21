// SPDX-License-Identifier: MIT
pragma solidity >=0.8.19<0.9.0;

interface IBasicPriceBook {

    function setPrice(uint256 _unitPrice) external;

    function getPrice(uint256 quantity) external view returns (uint256);

}