// SPDX-License-Identifier: MIT
pragma solidity >=0.8.19<=0.9.0;

interface IENSBookResolver {

    function resolve(bytes calldata, bytes calldata data) external view returns (bytes memory, address);

    function addEnsAddress(uint256 coinType, address _address) external;

}
