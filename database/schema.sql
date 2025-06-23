-- Step 1: Create the database
CREATE DATABASE studentDB;

-- Step 2: Use the newly created database
USE studentDB;

-- Step 3: Create the students table
CREATE TABLE students (
    PRN VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(100)
);
