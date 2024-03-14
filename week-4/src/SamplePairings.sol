// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {G1Point, G2Point} from "./Curve.sol";

contract SamplePairings {
    function run(G1Point calldata minus_a, G2Point calldata b, G1Point calldata c, G2Point calldata d)
        public
        view
        returns (bool)
    {
        uint256[12] memory input =
            [minus_a.x, minus_a.y, b.x[1], b.x[0], b.y[1], b.y[0], c.x, c.y, d.x[1], d.x[0], d.y[1], d.y[0]];
        (bool ok, bytes memory res) = address(0x08).staticcall(abi.encode(input));
        require(ok, "Wrong pairing!");

        return abi.decode(res, (bool));
    }
}
