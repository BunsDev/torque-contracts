pragma solidity ^0.8.0;

//  _________  ________  ________  ________  ___  ___  _______      
// |\___   ___\\   __  \|\   __  \|\   __  \|\  \|\  \|\  ___ \     
// \|___ \  \_\ \  \|\  \ \  \|\  \ \  \|\  \ \  \\\  \ \   __/|    
//     \ \  \ \ \  \\\  \ \   _  _\ \  \\\  \ \  \\\  \ \  \_|/__  
//      \ \  \ \ \  \\\  \ \  \\  \\ \  \\\  \ \  \\\  \ \  \_|\ \ 
//       \ \__\ \ \_______\ \__\\ _\\ \_____  \ \_______\ \_______\
//        \|__|  \|_______|\|__|\|__|\|___| \__\|_______|\|_______|

import "../interfaces/ISwapRouterV3.sol";
import "../interfaces/IStargateLPStaking.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "./vToken.sol";

contract StargateETH is Ownable, ReentrancyGuard {
    using SafeERC20 for IERC20;

    IERC20 public immutable weth;
    IStargate public immutable stargatePool;
    TorqueETH public immutable torqueETHInstance;

    constructor(IERC20 _weth, IStargate _stargatePool, address torqueETHAddress) {
        weth = _weth;
        stargatePool = _stargatePool;
        torqueETHInstance = TorqueETH(torqueETHAddress);
    }

    function deposit(uint256 _amount) external nonReentrant {
        weth.safeTransferFrom(msg.sender, address(this), _amount);
        weth.approve(address(stargatePool), _amount);
        stargatePool.deposit(_amount);
        torqueETHInstance.mint(msg.sender, _amount);
    }

    function withdraw(uint256 _amount) external nonReentrant {
        stargatePool.withdraw(_amount);
        weth.safeTransfer(msg.sender, _amount);
        torqueETHInstance.burn(msg.sender, _amount);
    }
}