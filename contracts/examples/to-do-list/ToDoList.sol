// SPDX-License-Identifier: MIT

pragma solidity = 0.7.2;

contract ToDoList {
    string[] tasks;

    event Info(string _event);

    //Read-only (will not trigger a transaction)
    function readTask(uint i) public view returns (string memory) {
        return tasks[i];
    }

    //Add a tasks (will create a transaction)
    function addTask(string memory _task) public {
        tasks.push(_task);
    }

    function triggerEvent(string memory _description) public {
        emit Info(_description);
    }
}
