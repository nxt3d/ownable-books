
//SPDX-License-Identifier: MIT
pragma solidity >=0.8.19<0.9.0;


interface IUnruggable {

    function pages(string memory key) external view returns (string memory policy);

    function writePage(string memory key, string memory policy) external;

    function burnEditFuse(string memory key) external;

}
