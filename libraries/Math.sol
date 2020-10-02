// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.8.0;

// a library for performing various math operations

library Math {
    function min(uint x, uint y) internal pure returns (uint z) {
        z = x < y ? x : y;
    }

    // Returns the average of two numbers. The result is rounded towards zero.
    function average(uint256 a, uint256 b) internal pure returns (uint256) {
        // (a + b) / 2 can overflow, so we distribute
        return (a / 2) + (b / 2) + ((a % 2 + b % 2) / 2);
    }

    // Returns the largest of two numbers.
    function max(uint256 a, uint256 b) internal pure returns (uint256) {
        return a >= b ? a : b;
    }

    // babylonian method (https://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Babylonian_method)
    function sqrt(uint y) internal pure returns (uint z) {
        if (y > 3) {
            z = y;
            uint x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
    }

    /**
    * @dev Compute modular exponential (x ** k) % m
    * @param x k m
    */

    function mexp(uint x, uint k, uint m) internal pure returns (uint r) {
        r = 1;
        for (uint s = 1; s <= k; s *= 2) {
            if (k & s != 0) r = mulmod(r, x, m);
            x = mulmod(x, x, m);
        }
    }

    function abs(int x) internal pure returns (uint) {
        if (x < 0) {
            return uint(-x);
        }
        return uint(x);
    }

    function u_pow(uint x, uint p) internal pure returns (uint) {
        if (p == 0) return 1;
        if (p % 2 == 1) {
            return u_pow(x, p - 1) * x;
        } else {
            return u_pow(x, p / 2) * u_pow(x, p / 2);
        }
    }

    function pow(int x, uint p) internal pure returns (int) {
        int r = int(u_pow(abs(x), p));
        if (p % 2 == 1) {
            return -1 * r;
        }
        return r;
    }
}
