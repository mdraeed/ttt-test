func displayBoard(board: [String]) {
    print()
    print("\(board[0]) | \(board[1]) | \(board[2])")
    print("---------")
    print("\(board[3]) | \(board[4]) | \(board[5])")
    print("---------")
    print("\(board[6]) | \(board[7]) | \(board[8])")
    print()

    print()
    print(" 1 | 2 | 3")
    print("------------")
    print(" 4 | 5 | 6 ")
    print("------------")
    print(" 7 | 8 | 9 ")
    print()
}
func isBoardEmpty(board: [String]) -> Bool {
    for i in 0 ..< board.count {
        if board[i] == " " {
            return true
        }
    }
    return false
}
func emptySpot(board: [String]) -> Int {
    var count : Int = 0
    for i in 0 ..< board.count {
        if board[i] ==  " " {
            count += 1
        }
    }
    return count
}
func checkWin(board: [String], letter: String) -> Bool {
    return ((board[0] == letter && board[1] == letter && board[2] == letter) || // Check 1st row
              (board[3] == letter && board[4] == letter && board[5] == letter) || // Check 2nd row
              (board[6] == letter && board[7] == letter && board[8] == letter) || // Check 3rd row
              (board[0] == letter && board[3] == letter && board[6] == letter) || // Check 1st column
              (board[1] == letter && board[4] == letter && board[7] == letter) || // Check 2nd column
              (board[2] == letter && board[5] == letter && board[8] == letter) || // Check 3rd column
              (board[6] == letter && board[4] == letter && board[2] == letter) || // Check lower left to upper right diagonal
              (board[0] == letter && board[4] == letter && board[8] == letter)) // Check upper left to lower right diagonal
}
func minimax(board: [String], depth: Int, maximum: Bool) -> Int {
    var board = board // Redeclare 'board' to make it a mutable variable
    if checkWin(board: board, letter: "O") {
        return 10
    } else if checkWin(board: board, letter: "X") {
        return -10
    } else if isBoardEmpty(board: board) == false {
        return 0
    }
    
    if maximum == true {
        var best : Int = -1000
        for i in 0 ..< board.count {
            if board[i] == " " {
                board[i] = "O"
                //let maximum = false
                best = max(best, minimax(board: board, depth: depth + 1, maximum: false))
                board[i] = " "
            }
        }
        return best + depth
    } else {
        var worst = 1000
        for i in 0 ..< board.count {
            if board[i] == " " {
                board[i] = "X"
                //let maximum = true
                worst = min(worst, minimax(board: board, depth: depth + 1, maximum: true))
                board[i] = " "
            }
        }
        return worst - depth
    }
}
func aiMove(board: [String]) -> Int {
    var board = board // Redeclare 'board' to make it a mutable variable
    var bestScore = -1000
    var winningMove = 0
    for i in 0 ..< board.count {
        if board[i] == " " {
            board[i] = "O"
            let moveScore = minimax(board: board, depth: 0, maximum: false)
            board[i] = " "
            if moveScore > bestScore {
                winningMove = i
                bestScore = moveScore
            }
        }
    }
    return winningMove
}
func playAgain() -> Void {
    print("Would you like to play again? [Y]es or [N]o.")
    let again = readLine()!.uppercased()
    if again.prefix(1) == "Y" {
        playGame()
    } else if again.prefix(1) == "N" {
        return
    } else {
        print("Invalid response.")
        playAgain()
    }
}
func playGame() {
    var board : [String] = [" ", " ", " ",
                            " ", " ", " ",
                            " ", " ", " "]
    var turn : Bool = false
    var running : Bool = true
    var multiplayer : Bool = false
    print("********* [ WELCOME TO TIC-TAC-TOE GAME ] *********")
    print("*                                                 *")
    print("*          INFO: HUMAN (X), COMPUTER (O)          *")
    print("*                                                 *")
    print("*              < GAME TABLE FORMAT >              *")
    print("*                                                 *")
    print("*                   1 | 2 | 3                     *")
    print("*                   ---------                     *")
    print("*                   4 | 5 | 6                     *")
    print("*                   ---------                     *")
    print("*                   7 | 8 | 9                     *")
    print("*                                                 *")
    print("***************************************************")
    print("[S]ingleplayer or [M]ultiplayer?")
    let multiplayerResponse = readLine()!
    if multiplayerResponse ~= "M" {
        multiplayer = true
    } else {
        multiplayer = false
    }
    
    while (isBoardEmpty(board: board) == true) && (running == true) && (multiplayer == false) {
        if turn == false {
            print("Please select a move from 1-9:")
            let position = readLine()!
            if 1...9 ~= Int(position)! {
                if board[Int(position)! - 1] == " " {
                    board[Int(position)! - 1] = "X"
                    turn = true
                } else {
                    print("That spot has already been taken! Please select an open spot.")
                }
            }
        } else {
            let position = aiMove(board: board)
            board[position] = "O"
            turn = false
            print("AI's Turn: ")
        }
        
        displayBoard(board: board)
        
        if checkWin(board: board, letter: "X") == true {
            print("Congratulations! You won!")
            playAgain()
            running = false
        } else if checkWin(board: board, letter: "O") == true {
            if multiplayer == false {
                print("Unfortunately, the AI won. Maybe next time 😏")
            } else {
                print("Congratulations! Player O won!")
            }
            playAgain()
            running = false
        } else if checkWin(board: board, letter: "X") == false && checkWin(board: board, letter: "O") == false && isBoardEmpty(board: board) == false {
            print("It's a tie! Maybe next time 😏")
            playAgain()
            running = false
        }
    }
    while (isBoardEmpty(board: board) == true) && (running == true) && (multiplayer == true) {
        if turn == false {
            print("Please select a move from 1-9:")
            let position = readLine()!
            if 1...9 ~= Int(position)! {
                if board[Int(position)! - 1] == " " {
                    board[Int(position)! - 1] = "X"
                    turn = true
                } else {
                    print("That spot has already been taken! Please select an open spot.")
                }
            }
            displayBoard(board: board)
        } else {
            print("Please select a move from 1-9:")
            let position = readLine()!
            if 1...9 ~= Int(position)! {
                if board[Int(position)! - 1] == " " {
                    board[Int(position)! - 1] = "O"
                    turn = false
                } else {
                    print("That spot has already been taken! Please select an open spot.")
                }
            1
        }
        
        displayBoard(board: board)
        
        if checkWin(board: board, letter: "X") == true {
            print("Congratulations! You won!")
            playAgain()
            running = false
        } else if checkWin(board: board, letter: "O") == true {
            print("Unfortunately, the AI won. Maybe next time 😏")
            playAgain()
            running = false
        } else if checkWin(board: board, letter: "X") == false && checkWin(board: board, letter: "O") == false && isBoardEmpty(board: board) == false {
            print("It's a tie! Maybe next time 😏")
            playAgain()
            running = false
        }
        }
    }
    
}
playGame()
