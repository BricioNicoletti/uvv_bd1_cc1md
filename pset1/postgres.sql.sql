-- SCRIPT  DO BANCO DE DADOS "LOJAS UVV".
-- Bricio Teixeira Nicoletti - cc1md.-


--  Conferirindo se já não existe um banco de dados com o mesmo nome, caso  possua um  deletá-lo e exclui-lo.
DROP DATABASE IF EXISTS uvv;
DROP USER IF EXISTS bricio;

--criando o usúario e a senha do banco de dados.
CREATE USER bricio WITH 
        createdb 
        createrole 
        encrypted password 'nicoletti';

--configurando o banco de dados.
CREATE DATABASE uvv WITH 
          owner = bricio
          encoding = "UTF8"
          lc_collate = 'pt_BR.UTF-8'
          lc_ctype = 'pt_BR.UTF-8'
          allow_connections = TRUE;

--comentario sobre o banco de dados que foi criado.
COMMENT ON DATABASE uvv IS 'Banco de Dados gerado e construido para se adequado ao Pset.';

--conexão com o banco de dados e o usúario.
\setenv PGPASSWORD nicoletti
\c uvv bricio;

--esquema do Schema .
CREATE SCHEMA IF NOT EXISTS lojas
AUTHORIZATION bricio;


COMMENT ON SCHEMA lojas IS 'Schema criado especificamente para a realização do projeto do Pset.';


ALTER USER bricio SET SEARCH_PATH TO lojas, "$user", public;
SET SEARCH_PATH TO lojas, "$user", public;

-- criação da tabela: produtos
CREATE TABLE produtos (
                produto_id NUMERIC(38),
                imagem BYTEA ,
                imagem_arquivo VARCHAR(512) ,
                imagem_ultima_atualizacao DATE ,
                nome VARCHAR(255) NOT NULL,
                imagem_mime_type VARCHAR(512) ,
                preco_unitario NUMERIC(10,2) ,
                imagem_charset VARCHAR(512) ,
                detalhes BYTEA ,
                CONSTRAINT produtos_pk PRIMARY KEY (produto_id)
);
-- comentarios sobre as colunas da tabela produtos
COMMENT ON TABLE produtos IS 'tabela dos produtos das lojas';
COMMENT ON COLUMN produtos.produto_id IS 'numeros dos id dos produtos';
COMMENT ON COLUMN produtos.imagem IS 'imagem dos produtos';
COMMENT ON COLUMN produtos.imagem_arquivo IS 'arquivos das imagens dos produtos';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'imagem da ultima atualizcao do produto';
COMMENT ON COLUMN produtos.nome IS 'nome dos produtos';
COMMENT ON COLUMN produtos.preco_unitario IS 'preço unitario dos produtos';
COMMENT ON COLUMN produtos.detalhes IS 'detalhes dos produtos';

-- criação da tabela: lojas
CREATE TABLE lojas (
                loja_id NUMERIC(38) NOT NULL,
                logo_arquivo VARCHAR(512) ,
                logo_mime_type VARCHAR(512) ,
                longitude NUMERIC ,
                logo BYTEA ,
                endereco_web VARCHAR(100) ,
                logo_ultima_atualizacao DATE ,
                logo_charset VARCHAR(512) ,
                endereco_fisico VARCHAR(512) ,
                latitude NUMERIC ,
                nome VARCHAR(255) NOT NULL,
                CONSTRAINT lojas_pk PRIMARY KEY (loja_id)
-- comentarios sobre as colunas da tabela lojas                
);
COMMENT ON TABLE lojas IS 'tabelas das lojas';
COMMENT ON COLUMN lojas.loja_id IS 'essa e a pk';
COMMENT ON COLUMN lojas.logo_arquivo IS 'logo do arquivo das lojas';
COMMENT ON COLUMN lojas.longitude IS 'longitude da loja';
COMMENT ON COLUMN lojas.logo IS 'logo marca das lojas';
COMMENT ON COLUMN lojas.endereco_web IS 'essa coluna e o endereço web';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'atualizacao da logo';
COMMENT ON COLUMN lojas.logo_charset IS 'charset da logo';
COMMENT ON COLUMN lojas.endereco_fisico IS 'endereço fisico das lojas';
COMMENT ON COLUMN lojas.latitude IS 'latitude da loja';
COMMENT ON COLUMN lojas.nome IS 'nomes das lojas';

-- criação da tabela: estoques
CREATE TABLE estoques (
                estoques_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                CONSTRAINT estoques_pk PRIMARY KEY (estoques_id)
);
-- comentarios sobre as colunas da tabela estoques
COMMENT ON TABLE estoques IS 'tabela dos estoques das lojas';
COMMENT ON COLUMN estoques.estoques_id IS 'id dos estoques, e a pk';
COMMENT ON COLUMN estoques.quantidade IS 'quantidade do estoques';
COMMENT ON COLUMN estoques.loja_id IS 'numeros do id das lojas';
COMMENT ON COLUMN estoques.produto_id IS 'numeros do id dos protudos';

-- criação da tabela: cliente
CREATE TABLE cliente (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20) ,
                telefone2 VARCHAR(20) ,
                telefone3 VARCHAR(20) ,
                CONSTRAINT cliente_pk PRIMARY KEY (cliente_id)
);
-- comentarios sobre as colunas da tabela cliente
COMMENT ON TABLE cliente IS 'Essa e a tabela cliente';
COMMENT ON COLUMN cliente.cliente_id IS 'Esse e o id dos cliente, é a pk';
COMMENT ON COLUMN cliente.email IS 'essa e a colunas dos emails';
COMMENT ON COLUMN cliente.nome IS 'essa coluna e o nome dos clientes';
COMMENT ON COLUMN cliente.telefone1 IS 'essa coluna dos telefone 1 dos clientes';
COMMENT ON COLUMN cliente.telefone2 IS 'essa coluna dos telefone 2 dos clientes';
COMMENT ON COLUMN cliente.telefone3 IS 'essa coluna dos telefone 3 dos clientes';

-- criação da tabela: envios
CREATE TABLE envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereço_de_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envios_pk PRIMARY KEY (envio_id)
);
-- comentarios sobre as colunas da tabela envios
COMMENT ON TABLE envios IS 'tabela dos envios';
COMMENT ON COLUMN envios.envio_id IS 'id dos envios, e a pk';
COMMENT ON COLUMN envios.loja_id IS 'numero dos id das lojas';
COMMENT ON COLUMN envios.cliente_id IS 'numero dos id dos clientes';
COMMENT ON COLUMN envios.endereço_de_entrega IS 'endereço de entrega dos envios';
COMMENT ON COLUMN envios.status IS 'status do envio';

-- criação da tabela: pedidos
CREATE TABLE pedidos (
                pedidos_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT pedidos_pk PRIMARY KEY (pedidos_id)
);
-- comentarios sobre as colunas da tabela pedidos
COMMENT ON COLUMN pedidos.pedidos_id IS 'numero do id dos pedidos';
COMMENT ON COLUMN pedidos.data_hora IS 'data e hora dos pedidos realizados';
COMMENT ON COLUMN pedidos.loja_id IS 'numero de id das lojas que querem fazer pedidos';
COMMENT ON COLUMN pedidos.cliente_id IS 'numero de id dos clientes que querem fazer os pedidos';
COMMENT ON COLUMN pedidos.status IS 'status dos pedidos feitos';

-- criação da tabela: pedidos_itens
CREATE TABLE pedidos_itens (
                produto_id NUMERIC(38) NOT NULL,
                pedidos_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC (38) NOT NULL,
                envio_id NUMERIC(38) ,
                CONSTRAINT pedidos_itens_pk PRIMARY KEY (produto_id, pedidos_id)
);
-- comentarios sobre as colunas da tabela pedidos intens
COMMENT ON TABLE pedidos_itens IS 'tabela dos pedidos de itens';
COMMENT ON COLUMN pedidos_itens.produto_id IS 'numeros do id dos produtos';
COMMENT ON COLUMN pedidos_itens.pedidos_id IS 'numero do id dos pedidos';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'numero das linhas dos pedidos';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'preço unitario dos produtos';
COMMENT ON COLUMN pedidos_itens.quantidade IS 'quantidade de intens dos pedidos';
COMMENT ON COLUMN pedidos_itens.envio_id IS 'numeros do id dos envios dos pedidos';


ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos ADD CONSTRAINT cliente_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES cliente (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE envios ADD CONSTRAINT cliente_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES cliente (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedidos_id)
REFERENCES pedidos (pedidos_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- constraint para garantir  a sequencia  lógica.


ALTER TABLE pedidos
ADD CONSTRAINT cc_pedidos_status
CHECK( status in('CANCELADO','COMPLETO','ABERTO','PAGO','REEMBOLSADO','ENVIADO') );

ALTER TABLE  envios
ADD CONSTRAINT cc_envios_status
CHECK( status in('CRIADO','ENVIADO','TRANSITO','ENTREGUE') );

ALTER TABLE pedidos_itens
ADD CONSTRAINT cc_pedidos_itens_quantidade
CHECK( quantidade > 0 );

ALTER TABLE estoques
ADD CONSTRAINT cc_estoques_quantidade
CHECK( quantidade > 0 );

ALTER TABLE lojas
ADD CONSTRAINT cc_lojas_endereco
CHECK( endereco_fisico IS NOT NULL OR endereco_web IS NOT NULL);


ALTER TABLE produtos
ADD CONSTRAINT cc_produtos_preco_unitario
CHECK( preco_unitario > 0 );

ALTER TABLE pedidos_itens
ADD CONSTRAINT cc_pedidos_itens_preco_unitario
CHECK( preco_unitario > 0 );
