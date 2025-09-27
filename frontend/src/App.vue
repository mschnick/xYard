<template>
  <div class="min-h-screen flex flex-col items-center justify-center bg-base-200 text-center">
    <h1 class="text-4xl font-bold mb-4">Welcome to xYard</h1>
    <p class="mb-6 text-lg">A Scotland Yard clone (a mere student project)</p>
    <button class="btn btn-primary" @click="startGame">Start new game</button>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router'

const router = useRouter()

function startGame() {
  router.push('/board')  // Du kannst später eine BoardView definieren
}
</script>