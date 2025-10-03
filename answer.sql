-- Create the database for the Library Management System
CREATE DATABASE library_management;
USE library_management;

-- Create Books table to store book details
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT,
    isbn VARCHAR(13) NOT NULL UNIQUE,
    title VARCHAR(255) NOT NULL,
    publication_year INT,
    genre VARCHAR(50),
    total_copies INT NOT NULL DEFAULT 1,
    available_copies INT NOT NULL DEFAULT 1,
    PRIMARY KEY (book_id),
    CHECK (available_copies <= total_copies)
);

-- Create Authors table to store author details
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    nationality VARCHAR(100),
    PRIMARY KEY (author_id)
);

-- Create Book_Authors table to handle many-to-many relationship between Books and Authors
CREATE TABLE Book_Authors (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE CASCADE
);

-- Create Members table to store library member details
CREATE TABLE Members (
    member_id INT AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    join_date DATE NOT NULL,
    PRIMARY KEY (member_id)
);

-- Create Loans table to track book loans by members
CREATE TABLE Loans (
    loan_id INT AUTO_INCREMENT,
    book_id INT,
    member_id INT,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    PRIMARY KEY (loan_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE RESTRICT,
    FOREIGN KEY (member_id) REFERENCES Members(member_id) ON DELETE RESTRICT,
    CHECK (due_date >= loan_date)
);