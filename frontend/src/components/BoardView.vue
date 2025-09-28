<script setup lang="ts">
const widthMm = 500
const heightMm = 700
// todo: scale to container
const pxPerMm = 3.78 // 96dpi
const widthPx = widthMm * pxPerMm
const heightPx = heightMm * pxPerMm
</script>

<template>
  <div class="w-full h-full overflow-auto bg-green-50">
    <div
      class="relative bg-white border border-blue-500"
      :style="{
        width: widthPx + 'px',
        height: heightPx + 'px'
      }"
    >
      <div style="width: 100%; height: 100%; background: red;">
        Ich bin das Spielfeld
      </div>
    </div>
  </div>
</template>