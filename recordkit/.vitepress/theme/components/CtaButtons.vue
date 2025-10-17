<script setup lang="ts">
import { VPButton } from 'vitepress/theme'
</script>

<template>
  <div class="rk-actions">
    <VPButton text="Try RecordKit for free" href="/try" theme="brand" size="medium" />
    <VPButton text="Get in touch" href="mailto:team+recordkit@nonstrict.com" theme="alt" size="medium" />
  </div>
</template>

<style scoped>
.rk-actions :deep(a) {
  text-decoration: none !important;
}
</style>
