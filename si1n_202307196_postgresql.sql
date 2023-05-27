-- Criando Table de produtos
CREATE TABLE produtos (
    produto_id NUMERIC(38) NOT NULL,
    nome VARCHAR(255) NOT NULL CHECK (nome ~* '^[A-Za-zÀ-ÿ\s]+$'),
    preco_unitario NUMERIC(10, 2) CHECK (preco_unitario >= 0),
    detalhes BYTEA,
    imagem BYTEA,
    imagem_mime_type VARCHAR(512),
    imagem_arquivo VARCHAR(512),
    imagem_charset VARCHAR(512),
    imagem_ultima_atualizacao DATE,
    CONSTRAINT produto_id PRIMARY KEY (produto_id)
);
-- Criando Table de lojas
CREATE TABLE lojas (
    loja_id NUMERIC(38) NOT null PRIMARY KEY ,
    nome VARCHAR(255) NOT NULL CHECK (nome ~* '^[A-Za-zÀ-ÿ\s]+$'),
    endereco_web VARCHAR(100),
    endereco_fisico VARCHAR(512),
    latitude NUMERIC,
    longitude NUMERIC,
    logo BYTEA,
    logo_mime_type VARCHAR(512),
    logo_arquivo VARCHAR(512),
    logo_charset VARCHAR(512),
    logo_ultima_atualizacao DATE,
    CONSTRAINT loja_id CHECK (COALESCE(endereco_web, endereco_fisico) IS NOT NULL)
);
-- Criando Table de clientes
CREATE TABLE clientes (
    cliente_id NUMERIC(38) NOT NULL,
    email VARCHAR(255) NOT NULL check (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    nome VARCHAR(255) NOT NULL CHECK (nome ~* '^[A-Za-zÀ-ÿ\s]+$'),
    telefone1 VARCHAR(20) CHECK (telefone1 ~ '^\+[0-9]{1,3}-[0-9]{1,14}$'),
    telefone2 VARCHAR(20) CHECK (telefone2 ~ '^\+[0-9]{1,3}-[0-9]{1,14}$'),
    telefone3 VARCHAR(20) CHECK (telefone3 ~ '^\+[0-9]{1,3}-[0-9]{1,14}$'),
    CONSTRAINT cliente_id PRIMARY KEY (cliente_id)
);
-- Criando Table de estoques
CREATE TABLE estoques (
    estoque_id NUMERIC(38) NOT NULL,
    loja_id NUMERIC(38) NOT NULL,
    produto_id NUMERIC(38) NOT NULL,
    quantidade NUMERIC(38) NOT NULL CHECK (quantidade >= 0),
    CONSTRAINT estoque_id PRIMARY KEY (estoque_id)
);
-- Criando Table de envios
CREATE TABLE envios (
    envio_id NUMERIC(38) NOT NULL,
    status VARCHAR(15) NOT NULL CHECK (status IN ('ENVIADO', 'CRIADO', 'TRANSITO', 'ENTREGUE')),
    loja_id NUMERIC(38) NOT NULL,
    cliente_id NUMERIC(38) NOT NULL,
    endereco_entrega VARCHAR(512) NOT NULL,
    CONSTRAINT envio_id PRIMARY KEY (envio_id)
);
-- Criando Table de pedidos
CREATE TABLE pedidos (
    pedido_id NUMERIC(38) NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    cliente_id NUMERIC(38) NOT NULL,
    status VARCHAR(15) NOT NULL CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO')),
    loja_id NUMERIC(38) NOT NULL,
    CONSTRAINT pedidos_id PRIMARY KEY (pedido_id)
);
-- Criando Table de pedidos_itens
CREATE TABLE pedidos_itens (
    produto_id NUMERIC(38) NOT NULL,
    pedido_id NUMERIC(38) NOT NULL,
    quantidade NUMERIC(38) NOT NULL CHECK (preco_unitario >= 0),
    numero_da_linha NUMERIC(38) NOT NULL,
    preco_unitario NUMERIC(10, 2) NOT NULL CHECK (preco_unitario >= 0),
    envio_id NUMERIC(38) NOT NULL,
    CONSTRAINT pedido_id PRIMARY KEY (produto_id, pedido_id)
);

ALTER TABLE estoques
ADD CONSTRAINT produtos_estoques_fk FOREIGN KEY (produto_id) REFERENCES produtos (produto_id) ON DELETE NO ACTION ON UPDATE NO ACTION NOT DEFERRABLE;
ALTER TABLE pedidos_itens
ADD CONSTRAINT produtos_pedidos_itens_fk FOREIGN KEY (produto_id) REFERENCES produtos (produto_id) ON DELETE NO ACTION ON UPDATE NO ACTION NOT DEFERRABLE;
ALTER TABLE envios
ADD CONSTRAINT lojas_envios_fk FOREIGN KEY (loja_id) REFERENCES lojas (loja_id) ON DELETE NO ACTION ON UPDATE NO ACTION NOT DEFERRABLE;
ALTER TABLE estoques
ADD CONSTRAINT lojas_estoques_fk FOREIGN KEY (loja_id) REFERENCES lojas (loja_id) ON DELETE NO ACTION ON UPDATE NO ACTION NOT DEFERRABLE;
ALTER TABLE pedidos
ADD CONSTRAINT lojas_pedidos_fk1 FOREIGN KEY (loja_id) REFERENCES lojas (loja_id) ON DELETE NO ACTION ON UPDATE NO ACTION NOT DEFERRABLE;
ALTER TABLE pedidos
ADD CONSTRAINT clientes_pedidos_fk FOREIGN KEY (cliente_id) REFERENCES clientes (cliente_id) ON DELETE NO ACTION ON UPDATE NO ACTION NOT DEFERRABLE;
ALTER TABLE envios
ADD CONSTRAINT clientes_envios_fk FOREIGN KEY (cliente_id) REFERENCES clientes (cliente_id) ON DELETE NO ACTION ON UPDATE NO ACTION NOT DEFERRABLE;
ALTER TABLE pedidos_itens
ADD CONSTRAINT envios_pedidos_itens_fk FOREIGN KEY (envio_id) REFERENCES envios (envio_id) ON DELETE NO ACTION ON UPDATE NO ACTION NOT DEFERRABLE;
ALTER TABLE pedidos_itens
ADD CONSTRAINT pedidos_pedidos_itens_fk FOREIGN KEY (pedido_id) REFERENCES pedidos (pedido_id) ON DELETE NO ACTION ON UPDATE NO ACTION NOT DEFERRABLE;

-- COMENTÁRIOS PRODUTOS
COMMENT ON COLUMN produtos.produto_id IS 'Identificador único para cada registro na tabela. É usado para referenciar de forma exclusiva cada entrada, facilitar a recuperação de dados específicos e nessa tabela está como primaryKey';
COMMENT ON COLUMN produtos.preco_unitario IS 'Armazena o valor unitário do produto';
COMMENT ON COLUMN produtos.detalhes IS 'Armazena detalhes sobre o produto';
COMMENT ON COLUMN produtos.imagem IS 'Armazena a imagem em dados binários como imagens, multimedia e arquivos PDF.';
COMMENT ON COLUMN produtos.imagem_mime_type IS 'Registra qual a extensão do arquivo da imagem';
COMMENT ON COLUMN produtos.imagem_arquivo IS 'Armazena o arquivo da imagem';
COMMENT ON COLUMN produtos.imagem_charset IS 'Armazena dados sobre a imagem';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'Armazena a data da última alteração da imagem';
-- COMENTÁRIOS LOJAS
COMMENT ON COLUMN lojas.loja_id IS 'Identificador único para cada registro na tabela. É usado para referenciar de forma exclusiva cada entrada, facilitar a recuperação de dados específicos e nessa tabela está como primaryKey';
COMMENT ON COLUMN lojas.nome IS 'Armazena o nome associado a um registro específico. Essa coluna é útil para identificar e pesquisar registros com base no nome de uma entidade.';
COMMENT ON COLUMN lojas.endereco_web IS 'Registra o endereço web associado a cada registro ';
COMMENT ON COLUMN lojas.endereco_fisico IS 'Registra o endereço fisico associado a cada registro de entrega';
COMMENT ON COLUMN lojas.latitude IS 'Registra a latitude da loja';
COMMENT ON COLUMN lojas.longitude IS 'Registra longitude da loja';
COMMENT ON COLUMN lojas.logo IS 'Armazena a logo em dados binários como imagens, multimedia e arquivos PDF.';
COMMENT ON COLUMN lojas.logo_mime_type IS 'Registra qual a extensão do arquivo da logo';
COMMENT ON COLUMN lojas.logo_arquivo IS 'Armazena o arquivo da logo';
COMMENT ON COLUMN lojas.logo_charset IS 'Armazena dados sobre a logo';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'Armazena a data da última alteração da logo';
-- COMENTÁRIOS CLIENTES
COMMENT ON COLUMN clientes.cliente_id IS 'Identificador único para cada registro na tabela. É usado para referenciar de forma exclusiva cada entrada, facilitar a recuperação de dados específicos e nessa tabela está como primaryKey';
COMMENT ON COLUMN clientes.email IS 'Armazena o endereço de e-mail associado a cada registro. Essa coluna é útil para comunicações por e-mail e permite a autenticação do usuário.';
COMMENT ON COLUMN clientes.nome IS 'Armazena o nome associado a um registro específico. Essa coluna é útil para identificar e pesquisar registros com base no nome de uma entidade.';
COMMENT ON COLUMN clientes.telefone1 IS 'Contém o número de telefone associado a um registro. Essa coluna é útil para comunicação por telefone e permite entrar em contato com os usuários de forma rápida e direta.';
COMMENT ON COLUMN clientes.telefone2 IS 'Contém o número de telefone associado a um registro. Essa coluna é útil para comunicação por telefone e permite entrar em contato com os usuários de forma rápida e direta.';
COMMENT ON COLUMN clientes.telefone3 IS 'Contém o número de telefone associado a um registro. Essa coluna é útil para comunicação por telefone e permite entrar em contato com os usuários de forma rápida e direta.';
-- COMENTÁRIOS ESTOQUES
COMMENT ON COLUMN estoques.estoque_id IS 'Identificador único para cada registro na tabela. É usado para referenciar de forma exclusiva cada entrada, facilitar a recuperação de dados específicos e nessa tabela está como primaryKey';
COMMENT ON COLUMN estoques.loja_id IS 'Identificador único para cada registro na tabela. É usado para referenciar de forma exclusiva cada entrada e facilitar a recuperação de dados específicos. Neste caso usado para identificar uma loja, nessa tabela está como foreignKey';
COMMENT ON COLUMN estoques.produto_id IS 'Identificador único para cada registro na tabela. É usado para referenciar de forma exclusiva cada entrada e facilitar a recuperação de dados específicos. Neste caso usado para identificar um produto, nessa tabela está como foreignKey';
COMMENT ON COLUMN estoques.quantidade IS 'Armazena a quantidade do produto no estoque';
-- COMENTÁRIOS ENVIOS
COMMENT ON COLUMN envios.envio_id IS 'Identificador único para cada registro na tabela. É usado para referenciar de forma exclusiva cada entrada, facilitar a recuperação de dados específicos e nessa tabela está como primaryKey';
COMMENT ON COLUMN envios.status IS 'Registra a atual situação do envio';
COMMENT ON COLUMN envios.loja_id IS 'Identificador único para cada registro na tabela. É usado para referenciar de forma exclusiva cada entrada e facilitar a recuperação de dados específicos.
Neste caso usado para identificar uma Loja, nessa tabela está como foreignKey';
COMMENT ON COLUMN envios.cliente_id IS 'Identificador único para cada registro na tabela. É usado para referenciar de forma exclusiva cada entrada e facilitar a recuperação de dados específicos.
Neste caso usado para identificar um cliente, nessa tabela está como foreignKey';
COMMENT ON COLUMN envios.endereco_entrega IS 'Registra o endereço fisico associado a cada registro de entrega';
-- COMENTÁRIOS PEDIDOS
COMMENT ON COLUMN pedidos.pedido_id IS 'Identificador único para cada registro na tabela. É usado para referenciar de forma exclusiva cada entrada, facilitar a recuperação de dados específicos e nessa tabela está como primaryKey';
COMMENT ON COLUMN pedidos.data_hora IS 'Armazena a data e hora do pedido';
COMMENT ON COLUMN pedidos.cliente_id IS 'Identificador único para cada registro na tabela. É usado para referenciar de forma exclusiva cada entrada e facilitar a recuperação de dados específicos.
Neste caso usado para identificar um cliente, nessa tabela está como foreignKey';
COMMENT ON COLUMN pedidos.status IS 'Registra a atual situação do pedido';
COMMENT ON COLUMN pedidos.loja_id IS 'Identificador único para cada registro na tabela. É usado para referenciar de forma exclusiva cada entrada e facilitar a recuperação de dados específicos.
Neste caso usado para identificar uma loja, nessa tabela está como foreignKey';
-- COMENTÁRIOS PEDIDOS ITENS
COMMENT ON COLUMN pedidos_itens.produto_id IS 'Identificador único para cada registro na tabela. É usado para referenciar de forma exclusiva cada entrada e facilitar a recuperação de dados específicos.
Neste caso usado para identificar um produto, nessa tabela está como chave estrangeira primária.';
COMMENT ON COLUMN pedidos_itens.pedido_id IS 'Identificador único para cada registro na tabela. É usado para referenciar de forma exclusiva cada entrada e facilitar a recuperação de dados específicos.
Neste caso usado para identificar um pedido, nessa tabela está como chave estrangeira primária.';
COMMENT ON COLUMN pedidos_itens.quantidade IS 'Armazena a quantidade de produtos no pedido';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'Armazena o número da linha do pedido';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'Armazena o valor unitário daquele produto no pedido';
COMMENT ON COLUMN pedidos_itens.envio_id IS 'Identificador único para cada registro na tabela. É usado para referenciar de forma exclusiva cada entrada e facilitar a recuperação de dados específicos.
Neste caso usado para identificar uma envio, nessa tabela está como foreignKey';
