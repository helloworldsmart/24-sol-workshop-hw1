// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import { Test } from "forge-std/src/Test.sol";
import { console2 } from "forge-std/src/console2.sol";

import { XueToken } from "../src/XueToken.sol";

/// @title XueTokenTest
/// @author Louis Tsai, Kevin Lin
/// @notice Do NOT modify this contract or you might get 0 points for the assingment.

contract XueTokenTest is Test {
    /*//////////////////////////////////////////////////////////////
                           STORAGE VARIABLES
    //////////////////////////////////////////////////////////////*/

    XueToken internal token;
    address internal Kevin;
    address internal Louis;
    address internal Jennifer;
    uint256 internal totalScore;

    /*//////////////////////////////////////////////////////////////
                                 EVENTS
    //////////////////////////////////////////////////////////////*/

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Claim(address indexed user, uint256 indexed amount);

    function setUp() public {
        _deployAndSetUpNewToken();
    }

    /*//////////////////////////////////////////////////////////////
                             DEFAULT TESTS
    //////////////////////////////////////////////////////////////*/

    function test_Decimal() public view {
        assertEq(token.decimals(), 18);
    }

    function test_Name() public view {
        assertEq(token.name(), "XueToken");
    }

    function test_Symbol() public view {
        assertEq(token.symbol(), "Xue");
    }

    function test_TotalSupply() public view {
        assertEq(token.totalSupply(), 2e18);
    }

    function test_BalanceOf() public view {
        assertEq(token.balanceOf(Kevin), 1e18);
        assertEq(token.balanceOf(Louis), 1e18);
    }

    /*//////////////////////////////////////////////////////////////
                   PART 1: COMPLETE TRANSFER FUNCTION
    //////////////////////////////////////////////////////////////*/

    function test_Transfer() public returns (bool) {
        vm.prank(Kevin);
        vm.expectEmit(true, true, false, false);
        emit Transfer(Kevin, Louis, 0.5e18);
        assertTrue(token.transfer(Louis, 0.5e18));

        assertEq(token.balanceOf(Kevin), 0.5e18);
        assertEq(token.balanceOf(Louis), 1.5e18);

        return true;
    }

    function test_Transfer_RevertWhen_BalanceNotEnough() public returns (bool) {
        vm.prank(Kevin);
        vm.expectRevert();
        token.transfer(Louis, 1.5e18);

        return true;
    }

    /*//////////////////////////////////////////////////////////////
            PART 2: COMPLETE APPROVE AND ALLOWANCE FUNCTION
    //////////////////////////////////////////////////////////////*/

    function test_Approve() public returns (bool) {
        vm.prank(Kevin);
        vm.expectEmit(true, true, false, false);
        emit Approval(Kevin, Louis, 1e18);
        assertTrue(token.approve(Louis, 1e18));
        assertEq(token.allowance(Kevin, Louis), 1e18);

        return true;
    }

    /*//////////////////////////////////////////////////////////////
                 PART 3: COMPLETE TRANSFERFROM FUNCTION
    //////////////////////////////////////////////////////////////*/

    function test_TransferFrom() public returns (bool) {
        vm.prank(Kevin);
        vm.expectEmit(true, true, false, false);
        emit Approval(Kevin, Louis, 1e18);
        assertTrue(token.approve(Louis, 1e18));

        vm.prank(Louis);
        vm.expectEmit(true, true, false, false);
        emit Transfer(Kevin, Jennifer, 1e18);
        assertTrue(token.transferFrom(Kevin, Jennifer, 1e18));

        assertEq(token.balanceOf(Kevin), 0);
        assertEq(token.balanceOf(Jennifer), 1e18);

        return true;
    }

    function test_TransferFrom_RevertWhen_AllowanceNotEnough() public returns (bool) {
        vm.prank(Louis);
        vm.expectRevert();
        token.transferFrom(Louis, Jennifer, 1e18);

        return true;
    }

    function test_TransferFrom_RevertWhen_BalanceNotEnough() public returns (bool) {
        vm.prank(Kevin);
        vm.expectEmit(true, true, false, false);
        emit Approval(Kevin, Louis, 1e18);
        assertTrue(token.approve(Louis, 0.5e18));

        vm.prank(Louis);
        vm.expectRevert();
        token.transferFrom(Louis, Jennifer, 2e18);

        return true;
    }

    /*//////////////////////////////////////////////////////////////
                               GET SCORE
    //////////////////////////////////////////////////////////////*/

    function test_CheckTransferPoints() public {
        if (test_Transfer() && test_Transfer_RevertWhen_BalanceNotEnough()) {
            console2.log("Get 30 points");
            totalScore += 30;
        }
    }

    function test_CheckApprovePoints() public {
        if (test_Approve()) {
            console2.log("Get 30 points");
            totalScore += 30;
        }
    }

    function test_CheckTransferFromPoints() public {
        if (
            test_TransferFrom() && test_TransferFrom_RevertWhen_AllowanceNotEnough()
                && test_TransferFrom_RevertWhen_BalanceNotEnough()
        ) {
            console2.log("Get 40 points");
            totalScore += 40;
        }
    }

    function test_GetTotalScore() public {
        _resetState();
        test_CheckTransferPoints();
        _resetState();
        test_CheckApprovePoints();
        _resetState();
        test_CheckTransferFromPoints();
        console2.log("Total Score:", totalScore);
    }

    function _deployAndSetUpNewToken() internal {
        token = new XueToken("XueToken", "Xue");
        Kevin = makeAddr("Kevin");
        Louis = makeAddr("Louis");
        Jennifer = makeAddr("Jennifer");

        vm.prank(Kevin);
        token.claim();

        vm.prank(Louis);
        token.claim();
    }

    function _resetState() internal {
        vm.roll(block.number + 1);
        _deployAndSetUpNewToken();
    }
}
