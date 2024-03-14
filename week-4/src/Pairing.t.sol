// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import {console2} from "forge-std/console2.sol";
import {Curve, G1Point, G2Point} from "./Curve.sol";
import {Pairing} from "./Pairing.sol";

contract PairingTest is Test {
    using Pairing for G1Point;

    G1Point internal g1 = Curve.g1();
    G2Point internal g2 = Curve.g2();

    function testNeg() public view {
        G1Point memory a = g1.mul(2);

        G1Point memory sum = a.add(a.neg());
        assertEq(sum.x, 0);
        assertEq(sum.y, 0);
    }

    function testMul() public view {
        G1Point memory a = g1.mul(5);
        G1Point memory sum = a.add(a);
        G1Point memory prod = a.mul(2);

        assertEq(prod.x, sum.x);
        assertEq(prod.y, sum.y);
    }

    function testPairing() public view {
        assert(g1.pair(g2, g1.neg(), g2));
    }

    function _print(G1Point memory p) internal view {
        console2.log("G1Point(%d, %d})", p.x, p.y);
    }

    function _print(G2Point memory p) internal view {
        console2.log("G2Point([uint256(%d), uint256(%d)]", p.x[0], p.y[0]);
        console2.log(", [uint256(%d), uint256($d)])", p.x[1], p.y[1]);
    }
}
