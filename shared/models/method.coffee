###
Represents an executable method.
###
class BDD.Method
  ###
  Constructor.
  @param func:  The function.
                A function with no parameters is considered synchronous.
                A function with a parameter is considered an async callback, eg:

                    (done) -> # Callback.

  ###
  constructor: (@func) ->
    @parent  = null # The parent [Suite].
    @isAsync = Util.params(@func).length > 0
    @timeout = 5000



  ###
  Invokes the test function.
  @param context:     The context within which to run (or null).
  @param done(err):   (Optional) A callback to invoke upon completion.
                                 An error if one occured (including timeout).
  ###
  run: (context, done) -> BDD.Method.run(@, context, done)




# CLASS METHODS ----------------------------------------------------------------------


###
Invokes a set of methods.
@param context:     The context within which to run (or null).
@param methods:     The set of Method objects.
@param done(err):   (Optional) A callback to invoke upon completion.
                               An error if one occured (including timeout).
###
# BDD.Method.runMethods = (context, methods, done) ->
#   # Setup initial conditions.
#   context ?= @
#   methods = [] unless Object.isArray(methods)





###
Invokes a set of methods.
@param method:      The Method object.
@param context:     The context within which to run (or null).
@param done(err):   (Optional) A callback to invoke upon completion.
                               An error if one occured (including timeout).
###
BDD.Method.run = (method, context, done) ->
  # Setup initial conditions.
  context ?= method
  if not (method instanceof BDD.Method)
    throw new Error('Not a [Method] object')

  if not Object.isFunction(method.func)
    done?(null)
    return


  if method.isAsync
    # Start timeout.
    timer = Util.delay method.timeout, =>
          if Object.isFunction(done)
            done(new Error('Timed out'))
            done = null # Ensure the callback cannot be invoked again.

    # Invoke async function.
    try
      method.func.call context, ->
          timer.stop()
          done?(null)
    catch e
      console?.error(e)
      done?(e)

  else
    # Invoke synchronously.
    try
      method.func.call(context)
      done?(null)
    catch e
      console?.error(e)
      done?(e)





