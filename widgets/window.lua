Window = Class({
    constructor = function(self, args)
        
        self.position = {x=args.x, y=args.y, w=args.w, h=args.h};
        self.name = args.name or ""
        self.parent = args.parent or false

        return self;
    end;

    setName = function(self, name)
        self.name = name;
        return self.name;
    end;

    destroy = function(self)
        -- Parents will be destroy in render
        self = nil;
        return true;
    end;
});

window = Window({x=0, y=0, w=200, h=200, name="test", parent=false});
