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
            alpha1: G1Point(
                1368015179489954701390400359078579693043519447331113978918064868415326638035,
                9918110051302171585080402603319702774565515993150576347155970296011118125764
                ),
            beta2: G2Point(
                [
                    uint256(18936818173480011669507163011118288089468827259971823710084038754632518263340),
                    uint256(18556147586753789634670778212244811446448229326945855846642767021074501673839)
                ],
                [
                    uint256(18825831177813899069786213865729385895767511805925522466244528695074736584695),
                    uint256(13775476761357503446238925910346030822904460488609979964814810757616608848118)
                ]
                ),
            gamma2: G2Point(
                [
                    uint256(11166086885672626473267565287145132336823242144708474818695443831501089511977),
                    uint256(1513450333913810775282357068930057790874607011341873340507105465411024430745)
                ],
                [
                    uint256(10576778712883087908382530888778326306865681986179249638025895353796469496812),
                    uint256(20245151454212206884108313452940569906396451322269011731680309881579291004202)
                ]
                ),
            delta2: G2Point(
                [
                    uint256(18946911109089220417246882279344009185046244062048267838251074785636587881882),
                    uint256(17937209039640432698657489930665601306227050938840470801941878726927091573255)
                ],
                [
                    uint256(7532430684487998364299773373743645376429834191630786809785815495450660596027),
                    uint256(13393908504037547765226354946599244623109994250574185355684102800893342919379)
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
