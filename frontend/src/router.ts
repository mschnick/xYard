import { createRouter, createWebHistory } from 'vue-router'
import App from './App.vue'
// später: import Board from './views/Board.vue'

const routes = [
  { path: '/', component: App },
  // { path: '/board', component: Board }, // folgt später
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router