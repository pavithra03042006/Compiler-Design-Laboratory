// 4.	Develop a C program that generates Abstract Syntax Trees (AST) from a given arithmetic expression.

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Node {
    char data;
    struct Node *left, *right;
} Node;

Node* createNode(char data) {
    Node* n = (Node*)malloc(sizeof(Node));
    n->data = data;
    n->left = n->right = NULL;
    return n;
}

const char *expr;
int pos = 0;

Node* parseExpr(); // Forward declaration

Node* parseFactor() {
    if (expr[pos] == '(') {
        pos++;
        Node* node = parseExpr();
        pos++;
        return node;
    }
    return createNode(expr[pos++]);
}

Node* parseTerm() {
    Node* node = parseFactor();
    while (expr[pos] == '*' || expr[pos] == '/') {
        Node* newNode = createNode(expr[pos++]);
        newNode->left = node;
        newNode->right = parseFactor();
        node = newNode;
    }
    return node;
}

Node* parseExpr() {
    Node* node = parseTerm();
    while (expr[pos] == '+' || expr[pos] == '-') {
        Node* newNode = createNode(expr[pos++]);
        newNode->left = node;
        newNode->right = parseTerm();
        node = newNode;
    }
    return node;
}

void printAST(Node* root, int space) {
    if (!root) return;
    space += 5;
    printAST(root->right, space);
    printf("\n%*c\n", space, root->data);
    printAST(root->left, space);
}

int main() {
    char input[100];
    printf("Enter arithmetic expression: ");
    scanf("%s", input);
    expr = input; pos = 0;
    Node* root = parseExpr();
    printf("\nAbstract Syntax Tree (AST):\n");
    printAST(root, 0);
    return 0;
}


//Enter arithmetic expression: a*b-c+d
//Abstract Syntax Tree (AST):
//               d
//          +
//                    c
//               -
//                         b
//                    *
//                         a
