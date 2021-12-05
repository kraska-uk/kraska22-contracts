const Kraska22 = artifacts.require('Kraska22');



contract('Kraska22', function (accounts) {
  describe('Common tests', () => {
    it('contract deployed', async () => {
      try {
        await Kraska22.deployed();
        return assert.isTrue(true);
      } catch (error) {
        return assert.isTrue(false);
      }
    });

    it('safeMint', async function () {
      const instance = await Kraska22.deployed();
      const tx1 = await instance.safeMint(accounts[1], [0]);
      console.log('tx1', tx1);
    });
  });
});
