-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "receta";

-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "user_schema";

-- CreateTable
CREATE TABLE "user_schema"."moneda" (
    "codigo" CHAR(3) NOT NULL,
    "nombre" VARCHAR(50) NOT NULL,

    CONSTRAINT "moneda_pkey" PRIMARY KEY ("codigo")
);

-- CreateTable
CREATE TABLE "user_schema"."usuario" (
    "id" UUID NOT NULL,
    "nombre" VARCHAR(50) NOT NULL,
    "correo_electronico" VARCHAR(100) NOT NULL,
    "contrasena_hash" VARCHAR(100) NOT NULL,
    "moneda_codigo" CHAR(3) NOT NULL DEFAULT 'MXN',

    CONSTRAINT "usuario_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_schema"."proveedor" (
    "id" UUID NOT NULL,
    "nombre" VARCHAR(50) NOT NULL,
    "num_celular" VARCHAR(15) NOT NULL,

    CONSTRAINT "proveedor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "receta"."unidad" (
    "id" INTEGER NOT NULL,
    "nombre" VARCHAR(50) NOT NULL,
    "cantidad_gramos" INTEGER,

    CONSTRAINT "unidad_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "receta"."ingrediente" (
    "id" INTEGER NOT NULL,
    "nombre" VARCHAR(50) NOT NULL,

    CONSTRAINT "ingrediente_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "receta"."marca" (
    "id" INTEGER NOT NULL,
    "nombre" VARCHAR(50) NOT NULL,

    CONSTRAINT "marca_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "receta"."tags" (
    "id" INTEGER NOT NULL,
    "nombre" VARCHAR(50) NOT NULL,

    CONSTRAINT "tags_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "receta"."tipo" (
    "id" INTEGER NOT NULL,
    "nombre" VARCHAR(50) NOT NULL,

    CONSTRAINT "tipo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "receta"."producto" (
    "id" UUID NOT NULL,
    "id_ingrediente" INTEGER NOT NULL,
    "id_marca" INTEGER NOT NULL,
    "id_unidad" INTEGER NOT NULL,
    "pzas" INTEGER,
    "precio_medio" DECIMAL(10,2) NOT NULL,
    "cantidad_inventario" INTEGER NOT NULL,
    "cantidad_unitario" INTEGER NOT NULL,
    "id_tipo" INTEGER NOT NULL,
    "id_usuario" UUID NOT NULL,

    CONSTRAINT "producto_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "receta"."receta" (
    "id" UUID NOT NULL,
    "profit" DECIMAL(10,2) NOT NULL,
    "nombre" VARCHAR(50) NOT NULL,
    "porciones_totales" INTEGER NOT NULL,
    "imagen_url" VARCHAR(300),
    "fecha_creacion" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "fecha_modificacion" TIMESTAMP(3),
    "id_usuario" UUID NOT NULL,

    CONSTRAINT "receta_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "receta"."insumo" (
    "id" UUID NOT NULL,
    "nombre" VARCHAR(50) NOT NULL,
    "precio_unitario" DECIMAL(10,2) NOT NULL,
    "id_unidad" INTEGER NOT NULL,
    "id_usuario" UUID NOT NULL,

    CONSTRAINT "insumo_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "receta"."tags_receta" (
    "id_receta" UUID NOT NULL,
    "id_tags" INTEGER NOT NULL,

    CONSTRAINT "tags_receta_pkey" PRIMARY KEY ("id_receta","id_tags")
);

-- CreateTable
CREATE TABLE "receta"."producto_proveedor" (
    "id_proveedor" UUID NOT NULL,
    "id_producto" UUID NOT NULL,
    "precio" DECIMAL(10,2) NOT NULL,

    CONSTRAINT "producto_proveedor_pkey" PRIMARY KEY ("id_proveedor","id_producto")
);

-- CreateTable
CREATE TABLE "receta"."receta_producto" (
    "id_receta" UUID NOT NULL,
    "id_producto" UUID NOT NULL,
    "cantidad" DECIMAL(10,2) NOT NULL,
    "fecha_creacion" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "receta_producto_pkey" PRIMARY KEY ("id_receta","id_producto")
);

-- CreateTable
CREATE TABLE "receta"."receta_insumo" (
    "id_receta" UUID NOT NULL,
    "id_insumo" UUID NOT NULL,
    "cantidad" DECIMAL(10,2) NOT NULL,

    CONSTRAINT "receta_insumo_pkey" PRIMARY KEY ("id_receta","id_insumo")
);

-- CreateTable
CREATE TABLE "receta"."receta_pasos" (
    "id" INTEGER NOT NULL,
    "id_receta" UUID NOT NULL,
    "paso" VARCHAR(300),
    "orden" INTEGER NOT NULL,

    CONSTRAINT "receta_pasos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "receta"."entrada" (
    "id" UUID NOT NULL,
    "fecha" DATE NOT NULL,
    "estado" BOOLEAN NOT NULL,
    "total" DECIMAL(10,2) NOT NULL,
    "id_proveedor" UUID NOT NULL,

    CONSTRAINT "entrada_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "receta"."detalle_entrada" (
    "id" INTEGER NOT NULL,
    "id_producto" UUID NOT NULL,
    "id_entrada" UUID NOT NULL,
    "precio" DECIMAL(10,2) NOT NULL,
    "cantidad" DECIMAL(10,2) NOT NULL,

    CONSTRAINT "detalle_entrada_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "receta"."salida" (
    "id" UUID NOT NULL,
    "fecha" DATE NOT NULL,
    "estado" BOOLEAN NOT NULL,
    "total" DECIMAL(10,2) NOT NULL,
    "id_receta" UUID NOT NULL,

    CONSTRAINT "salida_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "receta"."detalle_salida" (
    "id" INTEGER NOT NULL,
    "id_salida" UUID NOT NULL,
    "id_producto" UUID NOT NULL,
    "cantidad" INTEGER NOT NULL,

    CONSTRAINT "detalle_salida_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "usuario_correo_electronico_key" ON "user_schema"."usuario"("correo_electronico");

-- AddForeignKey
ALTER TABLE "user_schema"."usuario" ADD CONSTRAINT "usuario_moneda_codigo_fkey" FOREIGN KEY ("moneda_codigo") REFERENCES "user_schema"."moneda"("codigo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta"."producto" ADD CONSTRAINT "producto_id_ingrediente_fkey" FOREIGN KEY ("id_ingrediente") REFERENCES "receta"."ingrediente"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta"."producto" ADD CONSTRAINT "producto_id_marca_fkey" FOREIGN KEY ("id_marca") REFERENCES "receta"."marca"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta"."producto" ADD CONSTRAINT "producto_id_unidad_fkey" FOREIGN KEY ("id_unidad") REFERENCES "receta"."unidad"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta"."producto" ADD CONSTRAINT "producto_id_tipo_fkey" FOREIGN KEY ("id_tipo") REFERENCES "receta"."tipo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta"."producto" ADD CONSTRAINT "producto_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "user_schema"."usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta"."receta" ADD CONSTRAINT "receta_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "user_schema"."usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta"."insumo" ADD CONSTRAINT "insumo_id_unidad_fkey" FOREIGN KEY ("id_unidad") REFERENCES "receta"."unidad"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta"."insumo" ADD CONSTRAINT "insumo_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "user_schema"."usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta"."tags_receta" ADD CONSTRAINT "tags_receta_id_receta_fkey" FOREIGN KEY ("id_receta") REFERENCES "receta"."receta"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta"."tags_receta" ADD CONSTRAINT "tags_receta_id_tags_fkey" FOREIGN KEY ("id_tags") REFERENCES "receta"."tags"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta"."producto_proveedor" ADD CONSTRAINT "producto_proveedor_id_proveedor_fkey" FOREIGN KEY ("id_proveedor") REFERENCES "user_schema"."proveedor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta"."producto_proveedor" ADD CONSTRAINT "producto_proveedor_id_producto_fkey" FOREIGN KEY ("id_producto") REFERENCES "receta"."producto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta"."receta_producto" ADD CONSTRAINT "receta_producto_id_receta_fkey" FOREIGN KEY ("id_receta") REFERENCES "receta"."receta"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta"."receta_producto" ADD CONSTRAINT "receta_producto_id_producto_fkey" FOREIGN KEY ("id_producto") REFERENCES "receta"."producto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta"."receta_insumo" ADD CONSTRAINT "receta_insumo_id_receta_fkey" FOREIGN KEY ("id_receta") REFERENCES "receta"."receta"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta"."receta_insumo" ADD CONSTRAINT "receta_insumo_id_insumo_fkey" FOREIGN KEY ("id_insumo") REFERENCES "receta"."insumo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta"."receta_pasos" ADD CONSTRAINT "receta_pasos_id_receta_fkey" FOREIGN KEY ("id_receta") REFERENCES "receta"."receta"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta"."entrada" ADD CONSTRAINT "entrada_id_proveedor_fkey" FOREIGN KEY ("id_proveedor") REFERENCES "user_schema"."proveedor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta"."detalle_entrada" ADD CONSTRAINT "detalle_entrada_id_producto_fkey" FOREIGN KEY ("id_producto") REFERENCES "receta"."producto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta"."detalle_entrada" ADD CONSTRAINT "detalle_entrada_id_entrada_fkey" FOREIGN KEY ("id_entrada") REFERENCES "receta"."entrada"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta"."salida" ADD CONSTRAINT "salida_id_receta_fkey" FOREIGN KEY ("id_receta") REFERENCES "receta"."receta"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta"."detalle_salida" ADD CONSTRAINT "detalle_salida_id_salida_fkey" FOREIGN KEY ("id_salida") REFERENCES "receta"."salida"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "receta"."detalle_salida" ADD CONSTRAINT "detalle_salida_id_producto_fkey" FOREIGN KEY ("id_producto") REFERENCES "receta"."producto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
