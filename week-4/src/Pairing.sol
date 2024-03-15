// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {G1Point, G2Point, Curve} from "./Curve.sol";

library Pairing {
    // bn128 field modulus
    address internal constant EC_ADD = address(0x06);
    address internal constant EC_MUL = address(0x07);
    address internal constant EC_PAIRING = address(0x08);

    function neg(G1Point memory p) internal pure returns (G1Point memory) {
        if (p.x == 0 && p.y == 0) {
            return G1Point(0, 0);
        }
        return G1Point(p.x, Curve.FIELD_MODULUS - (p.y % Curve.FIELD_MODULUS));
    }

    function add(G1Point memory p, G1Point memory q) internal view returns (G1Point memory) {
        (bool ok, bytes memory res) = EC_ADD.staticcall(abi.encode(p.x, p.y, q.x, q.y));
        require(ok, "ecAdd failed");

        (uint256 x, uint256 y) = abi.decode(res, (uint256, uint256));
        return G1Point(x, y);
    }

    function mul(G1Point memory p, uint256 n) internal view returns (G1Point memory) {
        (bool ok, bytes memory res) = EC_MUL.staticcall(abi.encode(p.x, p.y, n));
        require(ok, "ecMul failed");

        (uint256 x, uint256 y) = abi.decode(res, (uint256, uint256));
        return G1Point(x, y);
    }

    function pair(G1Point memory p1, G2Point memory p2, G1Point memory q1, G2Point memory q2)
        internal
        view
        returns (bool)
    {
        (bool ok, bytes memory res) = EC_PAIRING.staticcall(
            abi.encode(
                p1.x,
                p1.y,
                p2.x[0],
                p2.x[1],
                p2.y[0],
                p2.y[1],
                q1.x,
                q1.y,
                q2.x[0],
                q2.x[1],
                q2.y[0],
                q2.y[1]
            )
        );
        require(ok, "ecPair failed");

        return abi.decode(res, (bool));
    }

    function pair(
        G1Point memory p1,
        G2Point memory p2,
        G1Point memory q1,
        G2Point memory q2,
        G1Point memory r1,
        G2Point memory r2,
        G1Point memory s1,
        G2Point memory s2
    ) internal view returns (bool) {
        G1Point[4] memory a1 = [p1, q1, r1, s1];
        G2Point[4] memory a2 = [p2, q2, r2, s2];

        // Circumvent stack too deep error
        uint256[24] memory input;
        for (uint256 i = 0; i < 4; i++) {
            uint256 j = i * 6;
            input[j + 0] = a1[i].x;
            input[j + 1] = a1[i].y;
            input[j + 2] = a2[i].x[0];
            input[j + 3] = a2[i].x[1];
            input[j + 4] = a2[i].y[0];
            input[j + 5] = a2[i].y[1];
        }

        (bool ok, bytes memory res) = EC_PAIRING.staticcall(abi.encode(input));
        require(ok, "ecPair failed");

        return abi.decode(res, (bool));
    }
}
