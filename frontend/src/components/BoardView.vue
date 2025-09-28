<script setup lang="ts">
const widthMm = 500
const heightMm = 700
// todo: scale to container
</script>

<template>
  <div class="w-full h-full overflow-auto bg-green-50">
    <div
      class="relative bg-white border"
      :style="{
        width: widthMm + 'mm',
        height: heightMm + 'mm'
      }"
    >
      <!-- später: Spielfeldinhalte -->
       Ich bin das Spielfeld
    </div>
  </div>
</template>