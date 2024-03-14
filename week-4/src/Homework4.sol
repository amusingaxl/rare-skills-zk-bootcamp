// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {G1Point, G2Point, Curve} from "./Curve.sol";
import {Pairing} from "./Pairing.sol";

contract Homework4 {
    using Pairing for G1Point;

    struct VerifyingKey {
        G1Point alpha1;
        G2Point beta2;
        G2Point gamma2;
        G2Point delta2;
    }

    function verifyingKey() internal pure returns (VerifyingKey memory) {
        return VerifyingKey({
            alpha1: G1Point(1, 2),
            beta2: G2Point(
                [
                    uint256(18029695676650738226693292988307914797657423701064905010927197838374790804409),
                    uint256(2140229616977736810657479771656733941598412651537078903776637920509952744750)
                ],
                [
                    uint256(14583779054894525174450323658765874724019480979794335525732096752006891875705),
                    uint256(11474861747383700316476719153975578001603231366361248090558603872215261634898)
                ]
                ),
            gamma2: G2Point(
                [
                    uint256(2725019753478801796453339367788033689375851816420509565303521482350756874229),
                    uint256(2512659008974376214222774206987427162027254181373325676825515531566330959255)
                ],
                [
                    uint256(7273165102799931111715871471550377909735733521218303035754523677688038059653),
                    uint256(957874124722006818841961785324909313781880061366718538693995380805373202866)
                ]
                ),
            delta2: G2Point(
                [
                    uint256(18936818173480011669507163011118288089468827259971823710084038754632518263340),
                    uint256(18825831177813899069786213865729385895767511805925522466244528695074736584695)
                ],
                [
                    uint256(18556147586753789634670778212244811446448229326945855846642767021074501673839),
                    uint256(13775476761357503446238925910346030822904460488609979964814810757616608848118)
                ]
                )
        });
    }

    function verify(G1Point calldata a1, G2Point calldata b2, G1Point calldata c1, uint256 x1, uint256 x2, uint256 x3)
        external
        view
        returns (bool verified)
    {
        G1Point memory g1 = Curve.g1();
        G1Point memory z1 = g1.mul(x1).add(g1.mul(x2)).add(g1.mul(x3));

        VerifyingKey memory vk = verifyingKey();

        return Pairing.pair(a1.neg(), b2, vk.alpha1, vk.beta2, z1, vk.gamma2, c1, vk.delta2);
    }
}
