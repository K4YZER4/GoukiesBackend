// types/ingrediente.types.ts

export interface VistaProducto {
  id: string;
  ingrediente: string;
  marca: string;
  tipo: string;
  unidad: string;
  pzas: number;
  precio_medio: string; // ojo: viene como string desde Prisma (Decimal)
  cantidad_inventario: number;
  cantidad_unitario: number;
}

export interface Ingrediente {
  id: number;
  nombre: string;
}

export interface Marca {
  id: number;
  nombre: string;
}

export interface Tipo {
  id: number;
  nombre: string;
}

export interface Unidad {
  id: number;
  nombre: string;
  cantidad_gramos: number;
}

export interface SelectAllIngredientesResponse {
  producto: VistaProducto[];
  ingredientes: Ingrediente[];
  marca: Marca[];
  tipo: Tipo[];
  unidad: Unidad[];
}
