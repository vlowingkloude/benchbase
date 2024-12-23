DROP TABLE IF EXISTS nation;
DROP TABLE IF EXISTS region;
DROP TABLE IF EXISTS part;
DROP TABLE IF EXISTS supplier;
DROP TABLE IF EXISTS partsupp;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS lineitem;

CREATE TABLE region (
                        r_regionkey integer  NOT NULL,
                        r_name      varchar(25) NOT NULL,
                        r_comment   varchar(152),
                        PRIMARY KEY (r_regionkey)
);

CREATE TABLE nation (
                        n_nationkey integer  NOT NULL,
                        n_name      varchar(25) NOT NULL,
                        n_regionkey integer  NOT NULL,
                        n_comment   varchar(152),
                        PRIMARY KEY (n_nationkey),
                        FOREIGN KEY (n_regionkey) REFERENCES region (r_regionkey) ON DELETE CASCADE
);

CREATE TABLE part (
                      p_partkey     integer        NOT NULL,
                      p_name        varchar(55)    NOT NULL,
                      p_mfgr        varchar(25)       NOT NULL,
                      p_brand       varchar(10)       NOT NULL,
                      p_type        varchar(25)    NOT NULL,
                      p_size        integer        NOT NULL,
                      p_container   varchar(10)       NOT NULL,
                      p_retailprice decimal(15, 2) NOT NULL,
                      p_comment     varchar(23)    NOT NULL,
                      PRIMARY KEY (p_partkey)
);

CREATE TABLE supplier (
                          s_suppkey   integer        NOT NULL,
                          s_name      varchar(25)       NOT NULL,
                          s_address   varchar(40)    NOT NULL,
                          s_nationkey integer        NOT NULL,
                          s_phone     varchar(15)       NOT NULL,
                          s_acctbal   decimal(15, 2) NOT NULL,
                          s_comment   varchar(101)   NOT NULL,
                          PRIMARY KEY (s_suppkey),
                          FOREIGN KEY (s_nationkey) REFERENCES nation (n_nationkey) ON DELETE CASCADE
);

CREATE TABLE partsupp (
                          ps_partkey    integer        NOT NULL,
                          ps_suppkey    integer        NOT NULL,
                          ps_availqty   integer        NOT NULL,
                          ps_supplycost decimal(15, 2) NOT NULL,
                          ps_comment    varchar(199)   NOT NULL,
                          PRIMARY KEY (ps_partkey, ps_suppkey),
                          FOREIGN KEY (ps_partkey) REFERENCES part (p_partkey) ON DELETE CASCADE,
                          FOREIGN KEY (ps_suppkey) REFERENCES supplier (s_suppkey) ON DELETE CASCADE
);

CREATE TABLE customer (
                          c_custkey    integer        NOT NULL,
                          c_name       varchar(25)    NOT NULL,
                          c_address    varchar(40)    NOT NULL,
                          c_nationkey  integer        NOT NULL,
                          c_phone      varchar(15)       NOT NULL,
                          c_acctbal    decimal(15, 2) NOT NULL,
                          c_mktsegment varchar(10)       NOT NULL,
                          c_comment    varchar(117)   NOT NULL,
                          PRIMARY KEY (c_custkey),
                          FOREIGN KEY (c_nationkey) REFERENCES nation (n_nationkey) ON DELETE CASCADE
);

CREATE TABLE orders (
                        o_orderkey      integer        NOT NULL,
                        o_custkey       integer        NOT NULL,
                        o_orderstatus   varchar(1)        NOT NULL,
                        o_totalprice    decimal(15, 2) NOT NULL,
                        o_orderdate     date           NOT NULL,
                        o_orderpriority varchar(15)       NOT NULL,
                        o_clerk         varchar(15)       NOT NULL,
                        o_shippriority  integer        NOT NULL,
                        o_comment       varchar(79)    NOT NULL,
                        PRIMARY KEY (o_orderkey),
                        FOREIGN KEY (o_custkey) REFERENCES customer (c_custkey) ON DELETE CASCADE
);

CREATE TABLE lineitem (
                          l_orderkey      integer        NOT NULL,
                          l_partkey       integer        NOT NULL,
                          l_suppkey       integer        NOT NULL,
                          l_linenumber    integer        NOT NULL,
                          l_quantity      decimal(15, 2) NOT NULL,
                          l_extendedprice decimal(15, 2) NOT NULL,
                          l_discount      decimal(15, 2) NOT NULL,
                          l_tax           decimal(15, 2) NOT NULL,
                          l_returnflag    varchar(1)        NOT NULL,
                          l_linestatus    varchar(1)        NOT NULL,
                          l_shipdate      date           NOT NULL,
                          l_commitdate    date           NOT NULL,
                          l_receiptdate   date           NOT NULL,
                          l_shipinstruct  varchar(25)       NOT NULL,
                          l_shipmode      varchar(10)       NOT NULL,
                          l_comment       varchar(44)    NOT NULL,
                          PRIMARY KEY (l_orderkey, l_linenumber),
                          FOREIGN KEY (l_orderkey) REFERENCES orders (o_orderkey) ON DELETE CASCADE,
                          FOREIGN KEY (l_partkey, l_suppkey) REFERENCES partsupp (ps_partkey, ps_suppkey) ON DELETE CASCADE
);