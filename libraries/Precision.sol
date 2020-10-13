// SPDX-License-Identifier: MIT

pragma solidity =0.7.3;

/**
 *    Note:
 *    double_t(1, 5) will be 1.05
 *    but
 *    double_t(1, 50) will be 1.5
 *
 *    example:
 *       import "multiprecision.sol";
 *       contract Test is Double
 *       {
 *           function test() internal
 *           {
 *               double memory a = double_t(1, 20); // 1.20
 *               double memory b = double_t(0, 2); // 0.02
 *               double memory result = double_add(a, b); // 1.22
 *
 *               a = double_t(2, 0); // 2.00
 *               b = double_t(1, 0); // 1.00
 *               a.sign = true; // -2.00
 *               result = double_add(a, b); // -2.00 + 1.00 = -1.00
 *
 *               result = double_sub(a, b); // -2.00 - 1.00 = -3.00
 *               result = double_mult(a, b); // -2.00 * 1.00 = -2.00
 *               result = double_div(a, b); // -2.00 / 1.00 = -2.00
 *
 *               dscale = 3; // change precision (.00 -> .000)
 *               double_t(1, 5); // now 1.005
 *               double_t(1, 50); // now 1.050
 *               double_t(1, 500); // now 1.500
 *           }
 *       }
 */

contract Double {
    uint256 private dscale = 2; // precision
    uint256 private dot = 10**dscale;
    struct double {
        uint256 part;
        uint256 f;
        bool sign;
    }

    function setPrecision(uint256 prec) internal {
        dscale = prec;
        dot = 10**dscale;
    }

    /**
     * @dev Creates new double instanse a.b
     * @param integral fractional
     */
    function double_t(int256 integral, uint256 fractional)
        internal
        pure
        returns (double memory data)
    {
        if (integral < 0) {
            data.sign = true;
            data.part = uint256(-integral);
        } else {
            data.part = uint256(integral);
        }
        data.f = fractional;
    }

    function convert(double memory data) internal view returns (uint256 r) {
        uint256 integer = data.part * dot;
        assert(integer / data.part == dot);
        r = integer + data.f;
        assert(r - data.f == integer);
    }

    function normalize(
        uint256 num,
        uint256 exp,
        bool sign
    ) internal view returns (double memory data) {
        uint256 d = 10**exp;
        uint256 part = num / d;
        uint256 f = num % d;
        if (f % dot == 0) {
            f /= dot;
        }
        data.part = part;
        data.f = f;
        data.sign = sign;
    }

    // built-in ^ operator does not support bools.
    function xor(bool a, bool b) internal pure returns (bool) {
        if (a && b) return false;
        if (a || b) return true;
        return false;
    }

    /*
    // add, sub, mult, div
    */

    /**
     * @dev Sum two doubles
     * @param lhs rhs
     * @return lhs + rhs
     */
    function double_add(double memory lhs, double memory rhs)
        internal
        view
        returns (double memory)
    {
        uint256 l = convert(lhs);
        uint256 r = convert(rhs);
        if (lhs.sign == rhs.sign) {
            return normalize(l + r, 2, rhs.sign);
        } else {
            if (l > r) {
                return normalize(l - r, 2, lhs.sign);
            } else {
                return normalize(r - l, 2, rhs.sign);
            }
        }
    }

    /**
     * @param lhs rhs
     * @return lhs - rhs
     */
    function double_sub(double memory lhs, double memory rhs)
        internal
        view
        returns (double memory)
    {
        uint256 l = convert(lhs);
        uint256 r = convert(rhs);
        if (l > r) {
            if (lhs.sign != rhs.sign) {
                return normalize(l + r, 2, lhs.sign);
            } else {
                return normalize(l - r, 2, lhs.sign);
            }
        } else if (l < r) {
            if (rhs.sign != lhs.sign) {
                return normalize(l + r, 2, !lhs.sign);
            } else {
                return normalize(r - l, 2, !lhs.sign);
            }
        } else {
            double memory data;
            data.part = 0;
            data.f = 0;
            data.sign = false;
            return data;
        }
    }

    /**
     * @param lhs rhs
     * @return lhs * rhs
     */
    function double_mult(double memory lhs, double memory rhs)
        internal
        view
        returns (double memory)
    {
        uint256 l = convert(lhs);
        uint256 r = convert(rhs);
        return normalize(l * r, 4, xor(lhs.sign, rhs.sign));
    }

    /**
     * @param lhs rhs
     * @return lhs / rhs
     */
    function double_div(double memory lhs, double memory rhs)
        internal
        view
        returns (double memory)
    {
        uint256 l = convert(lhs);
        uint256 r = convert(rhs);
        return normalize((l * (10**dscale)) / r, 2, xor(lhs.sign, rhs.sign));
    }

    /*
    //  Equality
    */

    function double_lt(double memory lhs, double memory rhs)
        internal
        pure
        returns (bool)
    {
        if (lhs.sign && !rhs.sign) {
            return true;
        } else if (!lhs.sign && rhs.sign) {
            return false;
        }
        if (lhs.part == rhs.part) {
            return lhs.f < rhs.f;
        }
        return lhs.part < rhs.part;
    }

    function double_le(double memory lhs, double memory rhs)
        internal
        pure
        returns (bool)
    {
        return (double_lt(lhs, rhs) || double_eq(lhs, rhs));
    }

    function double_eq(double memory lhs, double memory rhs)
        internal
        pure
        returns (bool)
    {
        return (lhs.part == rhs.part &&
            lhs.f == rhs.f &&
            rhs.sign == lhs.sign);
    }

    function double_ge(double memory lhs, double memory rhs)
        internal
        pure
        returns (bool)
    {
        return (double_eq(lhs, rhs) || double_gt(lhs, rhs));
    }

    function double_gt(double memory lhs, double memory rhs)
        internal
        pure
        returns (bool)
    {
        if (lhs.sign && !rhs.sign) {
            return false;
        } else if (!lhs.sign && rhs.sign) {
            return true;
        }
        if (lhs.part == rhs.part) {
            return lhs.f > rhs.f;
        }
        return lhs.part > rhs.part;
    }

    /*
    // Conversation API
    */

    function double_from_array(int256[] memory data)
        internal
        pure
        returns (double[] memory)
    {
        uint256 r_index = 0;
        double[] memory result = new double[](data.length / 2);
        for (uint256 i = 0; i < data.length - 1; i += 2) {
            result[r_index].part = uint256(data[i]);
            result[r_index].f = uint256(data[i + 1]);
            r_index++;
        }
        return result;
    }

    function double_to_array(double[] memory data)
        internal
        pure
        returns (int256[] memory)
    {
        uint256 index = 0;
        int256[] memory result = new int256[](data.length * 2);
        for (uint256 i = 0; i < data.length; i++) {
            if (data[i].sign) result[index] = -int256(data[i].part);
            else result[index] = int256(data[i].part);
            result[index + 1] = int256(data[i].f);
            index += 2;
        }
        return result;
    }

    function reshape_int(int256[2] memory data)
        internal
        pure
        returns (double[] memory)
    {
        double[] memory res = new double[](data.length);
        for (uint256 i; i < data.length; i++) {
            res[i] = double_t(data[i], 0);
        }
        return res;
    }
}
