import type { IcePriority } from '../types/IceScore';

export const HIGH_PRIORITY_MIN_ICE = 10;
export const MEDIUM_PRIORITY_MIN_ICE = 5;

// getIcePriority devuelve la prioridad alta, media o baja que corresponde a una puntuación ICE.
export function getIcePriority(score: number): IcePriority {
  if (score >= HIGH_PRIORITY_MIN_ICE) {
    return 'high';
  }

  return score >= MEDIUM_PRIORITY_MIN_ICE ? 'medium' : 'low';
}
