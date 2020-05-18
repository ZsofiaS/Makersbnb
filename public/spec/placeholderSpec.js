describe('spy', function() {
  var mySpy
  var rSpy
  beforeEach(function() {
    mySpy = jasmine.createSpyObj('spy', ['greet', 'leet', 'take', 'foo'])
    rSpy = new Spyee();
    real = {
      rVal: function() {
        return 10
      }
    }
  });

  it('can have greet called on it', function() {
    mySpy.greet()
    expect(rSpy.name).toEqual('Jack')
  });

  it('has the leet method called on it by Spyee', function() {
    expect(rSpy.caller(mySpy)).toEqual(10)
  });

  it('calls leet on that object', function() {
    rSpy.caller(mySpy)
    expect(mySpy.leet).toHaveBeenCalled();
  });

  it('takes an argument when take is called', function() {
    rSpy.patter(mySpy)
    expect(mySpy.take).toHaveBeenCalledWith(20)
  });

  it('returns true when foo returns true', function() {
    mySpy.foo.and.returnValue(true)
    expect(mySpy.foo()).toEqual(true)
    //expect(rSpy.report(mySpy)).toBe(true)
  });

  it('it makes Math random return 203', function() {
    spyOn(Math, 'random').and.returnValue(203)
    expect(Math.random()).toEqual(203)
  });

  it('calls math random', function() {
    spyOn(Math, 'random');
    rSpy.rando();
    expect(Math.random).toHaveBeenCalled();
  });

  it('returns 10 as a real function', function() {
    spyOn(real, 'rVal').and.callThrough();
    expect(real.rVal()).toEqual(10);
  });
});