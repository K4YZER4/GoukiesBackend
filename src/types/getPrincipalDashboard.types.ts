// src/dashboard/interfaces/dashboard.interface.ts

export interface DashboardStats {
  total_recetas: number;
  total_ingredientes: number;
}

export interface DashboardReceta {
  id: string;
  nombre: string;
  descripcion: string;
  imagen_url: string;
}

export interface DashboardIngrediente {
  id: string;
  ingrediente: string;
  categoria: string;
  stock: number;
  unidad: string;
}

export interface DashboardData {
  stats: DashboardStats;
  recetas: DashboardReceta[];
  ingredientes: DashboardIngrediente[];
}

// Tipo que representa la FILA que regresa PostgreSQL
export interface RawDashboardRow {
  get_dashboard_data: DashboardData;
}
