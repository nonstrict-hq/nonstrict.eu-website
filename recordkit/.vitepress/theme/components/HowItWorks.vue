<script setup lang="ts">
import { ref } from 'vue'
const mode = ref<'swift' | 'electron'>('swift')
</script>

<template>
  <section id="how-it-works" class="rk-section">
    <h2>How it works</h2>

    <ol>
      <li>
        <strong>Install via SwiftPM / Electron</strong>
        <div style="margin: 0.5rem 0;">
          <div style="display: inline-flex; gap: .5rem; align-items: center;">
            <button @click="mode = 'swift'">Swift</button>
            <button @click="mode = 'electron'">Electron</button>
          </div>
        </div>

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
