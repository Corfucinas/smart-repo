// SPDX-License-Identifier: MIT

pragma solidity = 0.7.3;

/** Array wraper
* min() - returns minimal array element
* max() - returns maximal array element
* sum() - returns sum of all array elements
* set(uint []) - set array
* get() - returns stored array
* sort() - sorts all array elements
*/

//Uint Array

contract UintUtils {
    uint[] private data;
    function UintArray(uint[] memory _data) public {
        data = new uint[](_data.length);
        for (uint i = 0; i < _data.length; i++) {
            data[i] = _data[i];
        }
    }

    /**
     * @dev Returns minimal element in array
     * @return uint
     */
    function min() public view returns (uint) {
        uint minimal = data[0];
        for (uint i; i < data.length; i++) {
            if (data[i] < minimal) {
                minimal = data[i];
            }
        }
        return minimal;
    }

    /**
     * @dev Returns minimal element's index
     * @return uint
     */
    function imin() public view returns (uint) {
        uint minimal = 0;
        for (uint i; i < data.length; i++) {
            if (data[i] < data[minimal]) {
                minimal = i;
            }
        }
        return minimal;
    }

    /**
     * @dev Returns maximal element in array
     * @return uint
     */
    function max() public view returns (uint) {
        uint maximal = data[0];
        for (uint i; i < data.length; i++) {
            if (data[i] > maximal) {
                maximal = data[i];
            }
        }
        return maximal;
    }

    /**
     * @dev Returns maximal element's index
     * @return uint
     */
    function imax() public view returns (uint) {
        uint maximal = 0;
        for (uint i; i < data.length; i++) {
            if (data[i] > data[maximal]) {
                maximal = i;
            }
        }
        return maximal;
    }

    /**
     * @dev Compute sum of all elements
     * @return uint
     */
    function sum() public view returns (uint) {
        uint S;
        for (uint i; i < data.length; i++) {
            S += data[i];
        }
        return S;
    }

    /**
     * @dev assign new array pointer from _data
     * @param _data is array to assign
     */
    function set(uint[] memory _data) public {
        data = _data;
    }

    /**
     * @dev Get the contents of array
     * @return uint[]
     */
    function get() public view returns (uint[] memory) {
        return data;
    }

    function at(uint i) public view returns (uint) {
        return data[i];
    }

    function sort_item(uint pos) internal returns (bool) {
        uint w_min = pos;
        for (uint i = pos; i < data.length; i++) {
            if (data[i] < data[w_min]) {
                w_min = i;
            }
        }
        if (w_min == pos) return false;
        uint tmp = data[pos];
        data[pos] = data[w_min];
        data[w_min] = tmp;
        return true;
    }

    /**
     * @dev Sort the array
     */
    function sort() public {
        for (uint i = 0; i < data.length - 1; i++) {
            sort_item(i);
        }
    }
}

// Int Array

contract IntUtils {
    int[] private data;
    function IntArray(int[] memory _data) public {
        data = _data;
    }

    /**
     * @dev Returns minimal element in array
     * @return int
     */
    function min() public view returns (int) {
        int minimal = data[0];
        for (uint i; i < data.length; i++) {
            if (data[i] < minimal) {
                minimal = data[i];
            }
        }
        return minimal;
    }

    /**
     * @dev Returns minimal element's index
     * @return uint
     */
    function imin() public view returns (uint) {
        uint minimal = 0;
        for (uint i; i < data.length; i++) {
            if (data[i] < data[minimal]) {
                minimal = i;
            }
        }
        return minimal;
    }

    /**
     * @dev Returns maximal element in array
     * @return int
     */
    function max() public view returns (int) {
        int maximal = data[0];
        for (uint i; i < data.length; i++) {
            if (data[i] > maximal) {
                maximal = data[i];
            }
        }
        return maximal;
    }

    /**
     * @dev Returns maximal element's index
     * @return uint
     */
    function imax() public view returns (uint) {
        uint maximal = 0;
        for (uint i; i < data.length; i++) {
            if (data[i] > data[maximal]) {
                maximal = i;
            }
        }
        return maximal;
    }

    /**
     * @dev Compute sum of all elements
     * @return int
     */
    function sum() public view returns (int) {
        int S;
        for (uint i; i < data.length; i++) {
            S += data[i];
        }
        return S;
    }

    function set(int[] memory _data) public {
        data = _data;
    }

    function get() public view returns (int[] memory) {
        return data;
    }

    function at(uint i) public view returns (int) {
        return data[i];
    }

    function sort_item(uint pos) internal returns (bool) {
        uint w_min = pos;
        for (uint i = pos; i < data.length; i++) {
            if (data[i] < data[w_min]) {
                w_min = i;
            }
        }
        if (w_min == pos) return false;
        int tmp = data[pos];
        data[pos] = data[w_min];
        data[w_min] = tmp;
        return true;
    }

    /**
     * @dev Sort the array
     */
    function sort() public {
        for (uint i = 0; i < data.length - 1; i++) {
            sort_item(i);
        }
    }
}
