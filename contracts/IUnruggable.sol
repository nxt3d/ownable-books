
//SPDX-License-Identifier: MIT
pragma solidity >=0.8.17<0.9.0;


interface IUnruggable {

    function owner() external view returns (address);

    function pages(string memory key) external view returns (string memory policy);

    function writePage(string memory key, string memory policy) external;

    function burnEditFuse(string memory key) external;

    function addEnsAddress(uint256 coinType, address _address) external;

    function ensAddresses(uint256 coinType) external view returns (address _address);

    function supportsInterface(bytes4 interfaceId) external view returns (bool); 
}
