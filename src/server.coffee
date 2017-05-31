import koa from 'koa'
import koaBody from 'koa-bodyparser'
import Router from 'koa-router'
import Store from './store'


SERVER_PORT = 12000


app = new koa
router = new Router
app.use koaBody()


router.get '/insert/*', (ctx) ->
  if Object.keys(ctx.params).length > 1
    ctx.body = 'Can only insert one zip code at a time'
  else
    ctx.body = Store.insert(ctx.params['0'])

router.get '/delete/*', (ctx) ->
  if Object.keys(ctx.params).length > 1
    ctx.body = 'Can only delete one zip code at a time'
  else
    ctx.body = Store.delete(ctx.params['0'])

router.get '/has/*', (ctx) ->
  if Object.keys(ctx.params).length > 1
    ctx.body = 'Can only lookup one zip code at a time'
  else
    ctx.body = Store.has(ctx.params['0'])

router.get '/display', (ctx) ->
  ctx.body = Store.display()


app.use router.routes()
app.use router.allowedMethods()

app.use (ctx) ->
  ctx.redirect '/display'
  ctx.body = 'Unknown route. Only routes available: /insert/, /delete/, /has/ or /display'





app.listen(SERVER_PORT)

console.log "Server listening at http://localhost:12000"