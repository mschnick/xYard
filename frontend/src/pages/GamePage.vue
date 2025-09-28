<template>
    <div class="flex h-screen overflow-hidden">
      <BoardView class="flex-1 bg-gray-100" />
      <GameDashboard class="w-96 bg-white border-l shadow-lg" />
    </div>
</template>

<script setup lang="ts">
  import BoardView from '@/components/BoardView.vue'
  import GameDashboard from '@/components/GameDashboard.vue'
</script>