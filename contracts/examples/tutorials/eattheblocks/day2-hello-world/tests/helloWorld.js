const HelloWorldWeb = artifacts.require('HelloWorldWeb')

contract('HelloWorldWeb', () => {
  it('should return Hello World', async () => {
    const helloWorld = await HelloWorld.deployed()
    const result = await helloWorld.hello()
    assert(result === 'Hello World')
  })
})
