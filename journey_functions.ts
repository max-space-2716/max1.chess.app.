import { onCall, HttpsError } from "firebase-functions/v2/https";
import * as admin from "firebase-admin";

const db = admin.firestore();

export const calculateForecast = onCall(async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated.");
  }

  const userId = request.auth.uid;
  const journeyDoc = await db.collection("journey_profiles").doc(userId).get();

  if (!journeyDoc.exists) {
    throw new HttpsError("not-found", "Journey profile not found.");
  }

  const data = journeyDoc.data()!;
  const currentRating = data.currentFideRating || 1200;
  const velocity = data.improvementVelocity || 15.0;

  const forecastData = {
    forecastId: `fc_\${userId}_\${DateTime.now()}`,
    userId,
    currentRating,
    forecast30Days: currentRating + Math.round(velocity * 1.0),
    forecast90Days: currentRating + Math.round(velocity * 2.8),
    forecast365Days: currentRating + Math.round(velocity * 10.0),
    confidenceInterval: 0.85,
    calculatedAt: new Date().toISOString(),
  };

  await db
    .collection("users")
    .doc(userId)
    .collection("rating_forecasts")
    .doc("latest_forecast")
    .set(forecastData, { merge: true });

  return { success: true, forecast: forecastData };
});

export const updateMasteryScore = onCall(async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "User must be authenticated.");
  }

  const userId = request.auth.uid;
  const { tactical, positional, endgame, opening } = request.data;

  const score = (tactical * 0.35) + (positional * 0.25) + (endgame * 0.25) + (opening * 0.15);

  await db.collection("journey_profiles").doc(userId).set({
    overallMasteryScore: score,
    updatedAt: new Date().toISOString(),
  }, { merge: true });

  return { success: true, masteryScore: score };
});
