create database if not exists `serviu-subsidios` character set utf8 collate utf8_general_ci;

use `serviu-subsidios`;

create table region (
    id_region int auto_increment primary key,
    nombre varchar(100)
);

create table ciudad (
    id_ciudad int auto_increment primary key,
    nombre varchar(100),
    id_region int,
    foreign key (id_region) references region(id_region)
);

create table comuna (
    id_comuna int auto_increment primary key,
    nombre varchar(100),
    id_ciudad int,
    foreign key (id_ciudad) references ciudad(id_ciudad)
);


create table direccion (
    id_direccion int auto_increment PRIMARY KEY,
    direccion varchar(255),
    id_comuna int,
    foreign key (id_comuna) references comuna(id_comuna)
);

create table sexo (
    id_sexo int auto_increment primary key,
    descripcion varchar(50)
);

create table estado_civil (
    id_estado_civil int auto_increment primary key ,
    descripcion varchar(50)
);

create table postulante(
    id_postulante int auto_increment primary key,
    run varchar(20) unique,
    primer_nombre varchar(100),
    segundo_nombre varchar(100),
    apellido_paterno varchar(100),
    apellido_materno varchar(100),
    id_direccion int,
    correo_electronico varchar (255),
    id_sexo int,
    id_estado_civil int,
    lugar_trabajo varchar(255),
    profesion varchar(255),
    sueldo_promedio decimal(10,2),
    celular varchar(20),
    foreign key (id_direccion) references direccion(id_direccion),
    foreign key (id_sexo) references sexo(id_sexo),
    foreign key (id_estado_civil) references estado_civil(id_estado_civil)
);

alter table postulante add id_conyuge int null,
add foreign key (id_conyuge) references postulante(id_postulante);

create table estado_solicitud(
    id_estado_solicitud int auto_increment primary key,
    descripcion varchar(50)
);

create table solicitud(
    id_solicitud int auto_increment primary key,
    id_postulante int,
    fecha_postulacion date,
    id_estado_solicitud int,
    fecha_respuesta date,
    ahorro_inicial decimal(10,2),
    foreign key (id_postulante) references postulante(id_postulante),
    foreign key (id_estado_solicitud) references estado_solicitud(id_estado_solicitud)
);

create table categoria_observacion (
    id_categoria_observacion int auto_increment primary key,
    descripcion varchar(50)
);

create table observacion (
    id_observacion int auto_increment primary key,
    descripcion text,
    id_categoria_observacion int,
    foreign key (id_categoria_observacion) references categoria_observacion(id_categoria_observacion)
);

create table solicitud_observacion (
    id_solicitud int,
    id_observacion int,
    primary key (id_solicitud, id_observacion),
    foreign key (id_solicitud) references solicitud(id_solicitud),
    foreign key (id_observacion) references observacion(id_observacion)
);

create table sucursal_banco (
    id_sucursal_banco int auto_increment primary key,
    nombre varchar(100),
    id_direccion int,
    foreign key (id_direccion) references direccion(id_direccion)
);


create table cuenta_ahorro (
    id_cuenta_ahorro int auto_increment primary key,
    id_postulante int,
    id_sucursal_banco int,
    monto_inicial decimal(10,2),
    foreign key (id_postulante) references postulante(id_postulante),
    foreign key (id_sucursal_banco) references sucursal_banco(id_sucursal_banco)
);


create table deposito (
    id_deposito int auto_increment primary key,
    id_cuenta_ahorro int,
    monto decimal(10,2),
    fecha date,
    id_sucursal_banco int,
    foreign key (id_cuenta_ahorro) references cuenta_ahorro(id_cuenta_ahorro),
    foreign key (id_sucursal_banco) references sucursal_banco(id_sucursal_banco)
);

create table vivienda (
    id_vivienda int auto_increment primary key,
    identificador_fiscal varchar(100),
    id_direccion int,
    fecha_construccion date,
    metros_cuadrados decimal(10,2),
    precio_venta decimal(10,2),
    foreign key (id_direccion) references direccion(id_direccion)
);

create table postulacion_vivienda (
    id_postulante int,
    id_vivienda int,
    monto_subsidio decimal(10,2),
    primary key (id_postulante, id_vivienda),
    foreign key (id_postulante) references postulante(id_postulante),
    foreign key (id_vivienda) references vivienda(id_vivienda)
);

create table evaluador (
    id_evaluador int auto_increment primary key,
    run varchar(50) unique ,
    primer_nombre varchar(100),
    segundo_nombre varchar(100),
    apellido_paterno varchar(100),
    apellido_materno varchar(100),
    celular varchar(20),
    correo_electronico varchar(255),
    id_pareja int
);


create table pareja_evaluador (
    id_pareja int auto_increment primary key,
    id_evaluador1 int,
    id_evaluador2 int,
    foreign key (id_evaluador1) references evaluador(id_evaluador),
    foreign key (id_evaluador2) references evaluador(id_evaluador)
);

create table evaluacion (
    id_evaluacion int auto_increment primary key,
    id_vivienda int,
    id_pareja int,
    puntaje int check ( puntaje >= 0 and puntaje <= 100),
    descripcion_estado text,
    caracteristicas text,
    foreign key (id_vivienda) references vivienda(id_vivienda),
    foreign key (id_pareja) references pareja_evaluador(id_pareja)
);


