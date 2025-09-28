import { createRouter, createWebHistory } from 'vue-router'
// später: import Board from './views/Board.vue'
import HomeView from './pages/HomeView.vue'
import GamePage from './pages/GamePage.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: HomeView
  },
  {
    path: '/game',
    name: 'Game',
    component: GamePage // enthält Board + Dashboard
 }  
  // { path: '/board', component: Board }, // folgt später
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

// in main.ts oder router.ts
router.beforeEach((to, from, next) => {
    console.log(`[xYard] [${new Date().toISOString()}] Navigating from ${from.fullPath} to ${to.fullPath}`)    
    next()
  })



export default router