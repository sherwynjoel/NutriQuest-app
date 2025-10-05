const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

// Cloud Function to update leaderboard
exports.updateLeaderboard = functions.firestore
  .document('users/{userId}')
  .onUpdate(async (change, context) => {
    const before = change.before.data();
    const after = change.after.data();
    
    // Check if totalXP changed
    if (before.totalXP !== after.totalXP) {
      console.log(`User ${context.params.userId} XP changed from ${before.totalXP} to ${after.totalXP}`);
      
      // Update leaderboard collection
      const leaderboardRef = admin.firestore().collection('leaderboard');
      
      try {
        await leaderboardRef.doc(context.params.userId).set({
          userId: context.params.userId,
          displayName: after.displayName,
          photoURL: after.photoURL,
          totalXP: after.totalXP,
          level: after.level,
          lastUpdated: admin.firestore.FieldValue.serverTimestamp()
        });
        
        console.log(`Leaderboard updated for user ${context.params.userId}`);
      } catch (error) {
        console.error('Error updating leaderboard:', error);
      }
    }
  });

// Cloud Function to calculate user level
exports.calculateLevel = functions.https.onCall(async (data, context) => {
  // Verify authentication
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
  }
  
  const userId = context.auth.uid;
  const { totalXP } = data;
  
  // Calculate level based on XP (100 XP per level)
  const newLevel = Math.floor(totalXP / 100) + 1;
  
  try {
    // Update user level in Firestore
    await admin.firestore().collection('users').doc(userId).update({
      level: newLevel,
      lastLevelUpdate: admin.firestore.FieldValue.serverTimestamp()
    });
    
    return { level: newLevel };
  } catch (error) {
    console.error('Error calculating level:', error);
    throw new functions.https.HttpsError('internal', 'Error calculating level');
  }
});

// Cloud Function to award badges
exports.awardBadge = functions.https.onCall(async (data, context) => {
  // Verify authentication
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
  }
  
  const userId = context.auth.uid;
  const { badgeId, badgeName } = data;
  
  try {
    // Add badge to user's badges array
    await admin.firestore().collection('users').doc(userId).update({
      badges: admin.firestore.FieldValue.arrayUnion(badgeId),
      lastBadgeAwarded: {
        badgeId: badgeId,
        badgeName: badgeName,
        timestamp: admin.firestore.FieldValue.serverTimestamp()
      }
    });
    
    console.log(`Badge ${badgeId} awarded to user ${userId}`);
    return { success: true };
  } catch (error) {
    console.error('Error awarding badge:', error);
    throw new functions.https.HttpsError('internal', 'Error awarding badge');
  }
});

// Cloud Function to get global leaderboard
exports.getGlobalLeaderboard = functions.https.onCall(async (data, context) => {
  try {
    const leaderboardSnapshot = await admin.firestore()
      .collection('leaderboard')
      .orderBy('totalXP', 'desc')
      .limit(50)
      .get();
    
    const leaderboard = leaderboardSnapshot.docs.map(doc => ({
      userId: doc.id,
      ...doc.data()
    }));
    
    return { leaderboard };
  } catch (error) {
    console.error('Error getting leaderboard:', error);
    throw new functions.https.HttpsError('internal', 'Error getting leaderboard');
  }
});

// Cloud Function to process game results
exports.processGameResult = functions.https.onCall(async (data, context) => {
  // Verify authentication
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
  }
  
  const userId = context.auth.uid;
  const { gameType, score, correctAnswers, totalQuestions } = data;
  
  try {
    // Calculate XP based on game type and performance
    let xpGained = 0;
    switch (gameType) {
      case 'quiz':
        xpGained = correctAnswers * 10; // 10 XP per correct answer
        break;
      case 'food_sort':
        xpGained = correctAnswers * 5; // 5 XP per correct sort
        break;
      case 'meal_builder':
        xpGained = score; // XP equals the calculated score
        break;
      default:
        xpGained = 0;
    }
    
    // Update user's total XP
    await admin.firestore().collection('users').doc(userId).update({
      totalXP: admin.firestore.FieldValue.increment(xpGained),
      lastGamePlayed: {
        gameType: gameType,
        score: score,
        xpGained: xpGained,
        timestamp: admin.firestore.FieldValue.serverTimestamp()
      }
    });
    
    // Check for badge eligibility
    const userDoc = await admin.firestore().collection('users').doc(userId).get();
    const userData = userDoc.data();
    
    // Award badges based on achievements
    const badgesToAward = [];
    
    if (userData.totalXP >= 100 && !userData.badges.includes('first_100_xp')) {
      badgesToAward.push({ id: 'first_100_xp', name: 'First Steps' });
    }
    
    if (userData.totalXP >= 500 && !userData.badges.includes('quiz_master')) {
      badgesToAward.push({ id: 'quiz_master', name: 'Quiz Master' });
    }
    
    // Award badges
    for (const badge of badgesToAward) {
      await admin.firestore().collection('users').doc(userId).update({
        badges: admin.firestore.FieldValue.arrayUnion(badge.id)
      });
    }
    
    return { 
      xpGained, 
      newTotalXP: userData.totalXP + xpGained,
      badgesAwarded: badgesToAward 
    };
  } catch (error) {
    console.error('Error processing game result:', error);
    throw new functions.https.HttpsError('internal', 'Error processing game result');
  }
});
