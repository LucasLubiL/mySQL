CREATE DATABASE Biblioteca;
USE Biblioteca;

CREATE TABLE Livros (
 LivroID INT AUTO_INCREMENT PRIMARY KEY,
 Titulo VARCHAR(255) NOT NULL,
 Autor VARCHAR(255) NOT NULL,
 Status ENUM('Disponível', 'Emprestado') DEFAULT 'Disponível'
);

CREATE TABLE Usuarios (
 UsuarioID INT AUTO_INCREMENT PRIMARY KEY,
 Nome VARCHAR(255) NOT NULL
);

CREATE TABLE Transacoes (
 TransacaoID INT AUTO_INCREMENT PRIMARY KEY,
 LivroID INT,
 UsuarioID INT,
 DataEmprestimo DATE,
 DataDevolucao DATE,
 FOREIGN KEY (LivroID) REFERENCES Livros(LivroID),
 FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);

INSERT INTO Livros (Titulo, Autor, Status) VALUES
('O Senhor dos Anéis', 'J.R.R. Tolkien', 'Disponível'),
('1984', 'George Orwell', 'Disponível'),
('A Revolução dos Bichos', 'George Orwell', 'Emprestado'),
('Harry Potter e a Pedra Filosofal', 'J.K. Rowling', 'Disponível'),
('O Hobbit', 'J.R.R. Tolkien', 'Emprestado'),
('O Código Da Vinci', 'Dan Brown', 'Disponível'),
('O Alquimista', 'Paulo Coelho', 'Disponível');

INSERT INTO Usuarios (Nome) VALUES
('Ana Souza'),
('João Silva'),
('Maria Oliveira'),
('Pedro Costa'),
('Lucas Fernandes'),
('Fernanda Lima');

INSERT INTO Transacoes (LivroID, UsuarioID, DataEmprestimo, DataDevolucao) VALUES
(1, 1, '2024-07-01', '2024-07-15'),
(2, 2, '2024-07-05', '2024-07-20'),
(3, 3, '2024-06-25', '2024-07-10'),
(4, 4, '2024-07-10', NULL),
(5, 5, '2024-07-12', '2024-07-25'),
(6, 6, '2024-07-15', NULL),
(7, 1, '2024-07-18', '2024-07-30');



-- 1
DELIMITER //
CREATE PROCEDURE relatorio_emprestimo(in data_par date)
    BEGIN 
        select l.Titulo, u.Nome, t.DataEmprestimo, t.DataDevolucao from Livros l
        JOIN Transacoes t ON l.LivroID = t.LivroID
        JOIN Usuarios u ON t.UsuarioID = u.UsuarioID
        where t.DataEmprestimo = data_par;
    END // 
DELIMITER ;

call relatorio_emprestimo ('2024-07-15');


-- 2
DELIMITER //
CREATE TRIGGER status_livro
AFTER UPDATE ON Transacoes
   FOR EACH ROW
   BEGIN
      declare dat date;
      call verificar(new.TransacaoID, dat);
      IF dat <> null then
         update Livros
         set Status = 'Disponível'
         where Transacoes.LivroID = Livros.LivroID;
      end if ;
   END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE verificar(in Transacao_ID int, out dat date)
    BEGIN 
       select DataDevolucao into dat
       from Transacoes
       where TransacaoID = Transacao_ID;
    END // 
DELIMITER ;

update Transacoes
set DataDevolucao = '2024-07-25'
where LivroID = 5;

select * from Livros
where LivroID = 5;

select * from Transacoes
where UsuarioID = 5;


-- 3
Create USER 'bibliotecario'@'localhost' identified by 'bibliotecario123';
Grant select, insert, delete, update ON biblioteca.Livros TO 'bibliotecario'; 
show grants for 'bibliotecario';



