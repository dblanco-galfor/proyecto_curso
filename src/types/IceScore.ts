export interface IceScore {
  impact: number;
  confidence: number;
  effort: number;
}

export type IceField = keyof IceScore;

// IceScoreDraft representa valores ICE que el usuario aun puede no haber indicado.
export type IceScoreDraft = Record<IceField, number | null>;

// IcePriority clasifica una puntuación ICE según lo urgente que es la tarea.
export type IcePriority = 'high' | 'medium' | 'low';
