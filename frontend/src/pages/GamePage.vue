<template>
  <div class="flex h-screen overflow-hidden select-none">
    <!-- Spielfeld -->
    <div :style="{ width: boardWidth + '%' }" class="bg-gray-100 overflow-hidden">
      <BoardView />
    </div>

    <!-- Resizer -->
    <div
      class="w-2 cursor-col-resize bg-gray-300 hover:bg-gray-500 transition-colors"
      @mousedown="startDragging"
    ></div>

    <!-- Dashboard -->
    <div :style="{ width: dashboardWidth + '%' }" class="bg-white border-l shadow-lg">
      <GameDashboard />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import BoardView from '@/components/BoardView.vue'
import GameDashboard from '@/components/GameDashboard.vue'

// Breitenanteile in %
const boardWidth = ref(75)
const dashboardWidth = ref(25)

let isDragging = false

const startDragging = () => {
  isDragging = true
}

const stopDragging = () => {
  isDragging = false
}

const onMouseMove = (e: MouseEvent) => {
  if (!isDragging) return

  const totalWidth = window.innerWidth
  const newBoardPercent = (e.clientX / totalWidth) * 100
  const clampedBoard = Math.min(Math.max(newBoardPercent, 0), 100)
  const clampedDashboard = 100 - clampedBoard

  // Grenzen setzen
  if (clampedDashboard < 0 || clampedDashboard > 50) return

  boardWidth.value = clampedBoard
  dashboardWidth.value = clampedDashboard
}

onMounted(() => {
  window.addEventListener('mousemove', onMouseMove)
  window.addEventListener('mouseup', stopDragging)
})

onUnmounted(() => {
  window.removeEventListener('mousemove', onMouseMove)
  window.removeEventListener('mouseup', stopDragging)
})
</script>