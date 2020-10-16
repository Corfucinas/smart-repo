const DrizzleBoxSimpleStorage = artifacts.require('DrizzleBoxSimpleStorage')

contract('DrizzleBoxSimpleStorage', (accounts) => {
  it('...should store the value 89.', async () => {
    const DrizzleBoxSimpleStorageInstance = await DrizzleBoxSimpleStorage.deployed()

    // Set value of 89
    await DrizzleBoxSimpleStorageInstance.set(89, { from: accounts[0] })

    // Get stored value
    const storedData = await DrizzleBoxSimpleStorageInstance.storedData.call()

    assert.equal(storedData, 89, 'The value 89 was not stored.')
  })
})
