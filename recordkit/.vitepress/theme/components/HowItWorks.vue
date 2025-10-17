<script setup lang="ts">
import { ref } from 'vue'
import VPSwitch from 'vitepress/dist/client/theme-default/components/VPSwitch.vue'

const mode = ref<'swift' | 'electron'>('swift')

const toggleMode = () => {
  mode.value = mode.value === 'swift' ? 'electron' : 'swift'
}
</script>

<template>
  <section id="how-it-works" class="rk-section">
    <h2>How it works</h2>

    <div class="mode-switch" role="group" aria-label="Select implementation guide">
      <button
        type="button"
        class="mode-label"
        :class="{ active: mode === 'swift' }"
        @click="mode = 'swift'"
      >
        Swift
      </button>

      <VPSwitch
        class="mode-switch-control"
        :class="{ 'is-electron': mode === 'electron' }"
        :aria-checked="mode === 'electron'"
        role="switch"
        :title="mode === 'swift' ? 'Switch to Electron guide' : 'Switch to Swift guide'"
        @click="toggleMode"
      >
        <span class="mode-switch-icon swift" aria-hidden="true">S</span>
        <span class="mode-switch-icon electron" aria-hidden="true">E</span>
      </VPSwitch>

      <button
        type="button"
        class="mode-label"
        :class="{ active: mode === 'electron' }"
        @click="mode = 'electron'"
      >
        Electron
      </button>
    </div>

    <ol>
      <li>
        <strong>Install via SwiftPM / Electron</strong>

        <div v-if="mode === 'swift'">
          <pre><code>// Package.swift (snippet)
dependencies: [
  .package(url: "https://github.com/nonstrict/recordkit", from: "X.Y.Z")
]</code></pre>
        </div>
        <div v-else>
          <pre><code># terminal
npm install @nonstrict/recordkit
# or
pnpm add @nonstrict/recordkit
</code></pre>
        </div>
      </li>

      <li>
        <strong>Add a few lines to record screen + audio</strong>
        <div v-if="mode === 'swift'">
<pre><code>// Swift (conceptual example)
import RecordKit

let recorder = RKRecorder()
try recorder.start(.screenAndSystemAudio)
// ...
try recorder.stop()</code></pre>
        </div>
        <div v-else>
<pre><code>// Electron (conceptual example)
import { createRecorder } from '@nonstrict/recordkit'

const rk = createRecorder()
await rk.start({ screen: true, systemAudio: true })
// ...
await rk.stop()</code></pre>
        </div>
      </li>

      <li><strong>Build &amp; go!</strong></li>
      <li><strong>Finetune, add features, get a license, and launch!</strong></li>
    </ol>

    <p style="margin-top: .5rem;">
      <a href="#video">See RecordKit in action (video)</a>
    </p>
  </section>
</template>

<style scoped>
.mode-switch {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1rem;
  margin: 1rem auto 2rem;
}

.mode-label {
  border: none;
  background: none;
  font-size: 1.05rem;
  font-weight: 500;
  color: var(--rk-muted);
  cursor: pointer;
  transition: color 0.2s ease, transform 0.2s ease;
  padding: 0.3rem 0.5rem;
}

.mode-label:hover,
.mode-label:focus-visible {
  color: var(--rk-link-hover);
}

.mode-label.active {
  color: var(--rk-link);
  transform: translateY(-2px);
}

.mode-switch-control {
  width: 82px;
  height: 36px;
  border-radius: 18px;
  border: 1px solid var(--vp-input-border-color);
  background-color: var(--vp-input-switch-bg-color);
  transition: border-color 0.25s ease, background-color 0.25s ease;
}

.mode-switch-control:hover {
  border-color: var(--vp-c-brand-1);
}

.mode-switch-control :deep(.check) {
  top: 2px;
  left: 2px;
  width: 32px;
  height: 32px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.mode-switch-control :deep(.icon) {
  width: 32px;
  height: 32px;
  display: block;
  position: relative;
  border-radius: 50%;
  overflow: hidden;
}

.mode-switch-icon {
  position: absolute;
  inset: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 0.85rem;
  font-weight: 600;
  color: var(--vp-c-text-2);
  opacity: 0;
  transition: opacity 0.2s ease;
}

.mode-switch-control :deep(.icon) .mode-switch-icon.swift {
  opacity: 1;
}

.mode-switch-control.is-electron :deep(.icon) .mode-switch-icon.swift {
  opacity: 0;
}

.mode-switch-control.is-electron :deep(.icon) .mode-switch-icon.electron {
  opacity: 1;
}

.mode-switch-control.is-electron :deep(.check) {
  transform: translateX(46px);
}

@media (max-width: 720px) {
  .mode-switch {
    gap: 0.75rem;
  }

  .mode-switch-control {
    width: 72px;
  }

  .mode-switch-control.is-electron :deep(.check) {
    transform: translateX(36px);
  }
}
</style>
