// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

interface IWETH {
    function deposit() external payable;

    function withdraw(uint wad) external;
}
