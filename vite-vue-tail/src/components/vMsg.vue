<script setup lang="ts">
import { ref } from 'vue'

defineProps<{ msg: string }>()

const count = ref(0)
</script>

<template>
  <div class="text-center p-6">
    <h1 class="text-4xl font-bold mb-4">{{ msg }}</h1>

    <div class="card p-6 bg-primary-950 rounded-xl shadow-md">
      <button
        class="px-4 py-2 bg-primary-500 ta-200 hover:bg-primary-700 text-white rounded-lg"
        @click="count++"
      >
        Count is {{ count }}
      </button>
      <p class="mt-4 text-gray-300">
        Edit <code class="text-green-400">components/vMsg.vue</code> to test HMR.
      </p>
    </div>

    <p class="mt-4">
      Check out
      <a
        class="text-primary-400 ta-200 hover:underline"
        href="https://vuejs.org/guide/quick-start.html#local"
        target="_blank"
      >
        create-vue </a
      >, the official Vue + Vite starter.
    </p>
  </div>
</template>
