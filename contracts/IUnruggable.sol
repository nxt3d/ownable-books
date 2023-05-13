
//SPDX-License-Identifier: MIT
pragma solidity >=0.8.17<0.9.0;


interface IUnruggable {

    function owner() external view returns (address);

    function pages(string memory key) external view returns (string memory policy);

    function writePage(string memory key, string memory policy) external;

}
