// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract TodoContract {
  
    struct Todo {
        uint256 id;
        string task;
        bool isCompleted;
        uint256 timestamp;
    }

    mapping(address => Todo[]) public todos;
    mapping(address => uint256) public userTodoCount; // how many a user have ?

    function createTodo(string memory _task) public {
        uint256 _id = ++userTodoCount[msg.sender];
        Todo memory newTodo = Todo({
            id: _id,
            task: _task,
            isCompleted: false,
            timestamp: block.timestamp
        });
        todos[msg.sender].push(newTodo);
    }

    function toggleTodo(uint256 _id) public {
        uint256 _length = userTodoCount[msg.sender];
        for (uint256 i = 0; i < _length; i++) {
            if (todos[msg.sender][i].id == _id) {
                todos[msg.sender][i].isCompleted = !todos[msg.sender][i]
                    .isCompleted;
                break;
            }
        }
    }

    function deleteTodo(uint256 _id) public {
        uint256 _length = userTodoCount[msg.sender];
        for (uint256 i = 0; i < _length; i++) {
            if (todos[msg.sender][i].id == _id) {
                delete todos[msg.sender][i];
                break;
            }
        }
    }

    function getTodos(address _user) public view returns (Todo[] memory) {
        uint256 _totalTodos = userTodoCount[_user]; // Total todos for the user
        uint256 _validTodoCount = 0;

        for (uint256 i = 0; i < _totalTodos; i++) {
            if (todos[_user][i].id != 0) {
                _validTodoCount++;
            }
        }

        Todo[] memory _userTodos = new Todo[](_validTodoCount);
        uint256 _counter = 0;
        for (uint256 i = 0; i < _totalTodos; i++) {
            if (todos[_user][i].id != 0) {
                _userTodos[_counter] = todos[_user][i];
                _counter++;
            }
        }

        return _userTodos;
    }
}
