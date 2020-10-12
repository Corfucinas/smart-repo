// SPDX-License-Identifier: MIT

pragma solidity =0.7.3;

contract ToDoList {
    string[] internal tasks;

    event Info(string _event);

    //Read-only (will not trigger a transaction)
    function readTask(uint256 i) external view returns (string memory) {
        return tasks[i];
    }

    //Add a tasks (will create a transaction)
    function addTask(string memory _task) external {
        tasks.push(_task);
    }

    function triggerEvent(string memory _description) external {
        emit Info(_description);
    }
}
