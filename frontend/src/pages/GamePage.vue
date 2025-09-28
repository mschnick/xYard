<template>
  <div class="flex h-screen overflow-hidden">
    <!-- Board soll flexibel Platz einnehmen -->
    <div class="flex-1 bg-gray-100 overflow-hidden">
      <BoardView />
    </div>

    <!-- Dashboard mit fixer Breite -->
    <div class="w-96 border-l shadow-lg bg-white">
      <GameDashboard />
    </div>
  </div>
</template>

<script setup lang="ts">
import BoardView from '@/components/BoardView.vue'
import GameDashboard from '@/components/GameDashboard.vue'
</script>