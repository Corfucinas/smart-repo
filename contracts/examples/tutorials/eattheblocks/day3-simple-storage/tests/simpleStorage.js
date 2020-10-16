const SimpleStorageExample = artifacts.require('SimpleStorageExample')

contract('SimpleStorageExample', () => {
  it('should set the value of data variable in smart contract', async () => {
    const simpleStorage = await SimpleStorageExample.deployed()
    await simpleStorage.set('this')
    const result = simpleStorage.get()
    assert(result, 'this')
  })
})
