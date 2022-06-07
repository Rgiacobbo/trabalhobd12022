DROP TABLE IF EXISTS CONTEMFOR_COMP,REALIZACOMP_FUNC,CONTEMCLI_VENDA,REALIZAFUNC_VEND,TEMCOMP_ITENC,CONTEMITENS_ITEN,POSSUIVEND_ITEN,REDUZITEN_EST,AUMENTAITENS_EST;
DROP TABLE IF EXISTS PESSOAS,FORNECEDOR,CLIENTE,ENDERECO,FUNCIONARIO,COMPRA,ITENSCOMPRADOS,VENDA,ITENSVENDIDOS,ITENS,ESTOQUE;


CREATE TABLE PESSOAS (idPessoa INTEGER,
					observacoes CHAR(255),
                    email CHAR(255),
                    telefone INTEGER,
PRIMARY KEY (idPessoa));
CREATE TABLE FORNECEDOR(idPJ INTEGER,
					nomeFonercedor CHAR(255),
                    RazaoSocial CHAR(255),
                    cnpj INTEGER,
                    idPessoa INTEGER,
PRIMARY KEY (idPJ,idPessoa),
FOREIGN KEY (idPessoa) REFERENCES PESSOAS (idPessoa) ON DELETE CASCADE);
CREATE TABLE CLIENTE(RG INTEGER,
					nomeCliente CHAR(255),
                    cpf INTEGER,
                    idPessoa INTEGER,
PRIMARY KEY (RG,idPessoa),
FOREIGN KEY (idPessoa) REFERENCES PESSOAS (idPessoa) ON DELETE CASCADE);
CREATE TABLE ENDERECO(idPessoa INTEGER,
					estado CHAR(100),
                    rua CHAR(255),
                    numero INTEGER,
                    observacao CHAR(255),
PRIMARY KEY (idPessoa,numero),
FOREIGN KEY (idPessoa) REFERENCES PESSOAS (idPessoa) ON DELETE CASCADE);
CREATE TABLE FUNCIONARIO(idFuncionario INTEGER,
					RG INTEGER,
					cargo CHAR(255),
                    cpf INTEGER,
                    dataDeNacimento date,
                    idPessoa INTEGER,
PRIMARY KEY (idFuncionario,idPessoa),
FOREIGN KEY (idPessoa) REFERENCES PESSOAS (idPessoa) ON DELETE CASCADE);

CREATE TABLE COMPRA(idCompra INTEGER,
					dataCompra date,
                    precoTotal INTEGER,
PRIMARY KEY(idCompra));
CREATE TABLE ITENSCOMPRADOS(idItensComprados INTEGER,
                    qtd INTEGER,
                    precoCompra INTEGER,
PRIMARY KEY(idItensComprados));

CREATE TABLE VENDA(idVenda INTEGER,
					dataVenda date,
                    precoTotal INTEGER,
                    precoVenda INTEGER,
PRIMARY KEY(idVenda));
CREATE TABLE ITENSVENDIDOS(idItensVendidos INTEGER,
                    qtd INTEGER,
                    precoVenda INTEGER,
PRIMARY KEY(idItensVendidos));
CREATE TABLE ITENS(idItens INTEGER,
					descricao CHAR(255),
					grupo CHAR(100),
                    precoCompra INTEGER,
                    precoVenda INTEGER,
PRIMARY KEY(idItens));
CREATE TABLE ESTOQUE(idEstoque INTEGER,
					qtdMovimento INTEGER,
					tipoMovimento CHAR(100),
                    salvo INTEGER,
                    idItens INTEGER NOT NULL,
PRIMARY KEY(idEstoque),
FOREIGN KEY(idItens) REFERENCES ITENS(idItens));
CREATE TABLE CONTEMFOR_COMP(idPJ INTEGER,
							idCompra INTEGER,
PRIMARY KEY(idCompra),
FOREIGN KEY (idCompra) REFERENCES COMPRA (idCompra),
FOREIGN KEY (idPJ) REFERENCES FORNECEDOR (idPJ));

CREATE TABLE REALIZACOMP_FUNC(idFuncionario INTEGER,
							idCompra INTEGER,
PRIMARY KEY(idCompra),
FOREIGN KEY (idCompra) REFERENCES COMPRA (idCompra),
FOREIGN KEY (idFuncionario) REFERENCES FUNCIONARIO (idFuncionario));

CREATE TABLE CONTEMCLI_VENDA(RG INTEGER,
							idVenda INTEGER,
PRIMARY KEY(idVenda),
FOREIGN KEY (idVenda) REFERENCES VENDA (idVenda),
FOREIGN KEY (RG) REFERENCES CLIENTE (RG));

CREATE TABLE REALIZAFUNC_VEND(idFuncionario INTEGER,
							idVenda INTEGER,
PRIMARY KEY(idVenda),
FOREIGN KEY (idVenda) REFERENCES VENDA (idVenda),
FOREIGN KEY (idFuncionario) REFERENCES FUNCIONARIO (idFuncionario));

CREATE TABLE TEMCOMP_ITENC(idItensComprados INTEGER,
							idCompra INTEGER,
PRIMARY KEY(idItensComprados),
FOREIGN KEY (idItensComprados) REFERENCES ITENSCOMPRADOS (idItensComprados),
FOREIGN KEY (idCompra) REFERENCES COMPRA (idCompra));

CREATE TABLE CONTEMITENS_ITEN(idItensComprados INTEGER,
							idItens INTEGER,
PRIMARY KEY(idItensComprados),
FOREIGN KEY (idItensComprados) REFERENCES ITENSCOMPRADOS (idItensComprados),
FOREIGN KEY (idItens) REFERENCES ITENS (idItens));

CREATE TABLE POSSUIVEND_ITEN(idItensVendidos INTEGER,
							idVenda INTEGER,
PRIMARY KEY(idItensVendidos),
FOREIGN KEY (idItensVendidos) REFERENCES ITENSVENDIDOS (idItensVendidos),
FOREIGN KEY (idVenda) REFERENCES VENDA (idVenda));

CREATE TABLE REDUZITEN_EST(idItensVendidos INTEGER,
							idEstoque INTEGER,
PRIMARY KEY(idItensVendidos),
FOREIGN KEY (idItensVendidos) REFERENCES ITENSVENDIDOS (idItensVendidos),
FOREIGN KEY (idEstoque) REFERENCES ESTOQUE (idEstoque));

CREATE TABLE AUMENTAITENS_EST(idItensComprados INTEGER,
							idEstoque INTEGER,
PRIMARY KEY(idItensComprados),
FOREIGN KEY (idItensComprados) REFERENCES ITENSCOMPRADOS (idItensComprados),
FOREIGN KEY (idEstoque) REFERENCES ESTOQUE (idEstoque));






