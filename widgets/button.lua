Button = Class({
    constructor = function(self, args)
        
        self.position = {x=args.x, y=args.y, w=args.w, h=args.h};
        self.name = args.name or ""
        self.parent = args.parent or false
        self.type = "Button";
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