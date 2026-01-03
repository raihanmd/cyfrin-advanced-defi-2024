// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Test, console2} from "forge-std/Test.sol";
import {
    IStableSwap3Pool
} from "../../../src/interfaces/curve/IStableSwap3Pool.sol";
import {IERC20} from "../../../src/interfaces/IERC20.sol";
import {DAI, USDC, USDT, CURVE_3POOL} from "../../../src/Constants.sol";

contract CurveV1SwapTest is Test {
    IStableSwap3Pool private constant pool = IStableSwap3Pool(CURVE_3POOL);
    IERC20 private constant dai = IERC20(DAI);
    IERC20 private constant usdc = IERC20(USDC);
    IERC20 private constant usdt = IERC20(USDT);

    int8 private constant DAI_INDEX = 0;
    int8 private constant USDC_INDEX = 1;
    int8 private constant USDT_INDEX = 2;

    function setUp() public {
        deal(DAI, address(this), 1e6 * 1e18);
        dai.approve(address(pool), type(uint256).max);
    }

    // Exercise 1
    // Call get_dy_underlying to calculate the amount of USDC for swapping
    // 1,000,000 DAI to USDC
    function test_get_dy_underlying() public {
        // Calculate swap from DAI to USDC
        // Write your code here
        uint256 dy = pool.get_dy_underlying(
            int128(DAI_INDEX), int128(USDC_INDEX), 1_000_000e18
        );

        console2.log("dy ", dy);
        assertGt(dy, 0, "dy = 0");
    }

    // Exercise 2
    // Call exchange to swap 1,000,000 DAI to USDC
    function test_exchange() public {
        // Swap DAI to USDC
        // Write your code here
        pool.exchange(int128(DAI_INDEX), int128(USDC_INDEX), 1_000_000e18, 0);

        uint256 bal = usdc.balanceOf(address(this));
        console2.log("USDC balance %e", bal);
        assertGt(bal, 0, "USDC balance = 0");
    }
}
