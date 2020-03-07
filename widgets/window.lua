Window = Class({
    constructor = function(self, args)
        self.position = {x=args.x, y=args.y, w=args.w, h=args.h};
        self.name = args.name or ""
        self.parent = args.parent or false
        self.type = "Window";
        self.effects = args.effects or {};
        self.text = {text = args.text, color = args.color or tocolor(255, 255, 255)}
        return self;
    end;

    render = function(self)
        if not self then
            return
        end
        dxDrawRectangle(self.position.x, self.position.y, self.position.w, self.position.h, tocolor(20, 20, 20, 200))
        dxDrawRectangle(self.position.x, self.position.y, self.position.w, 30, tocolor(20, 20, 20, 200))

        dxDrawText(self.text.main or "", self.position.x, self.position.y, self.position.w+self.position.x, self.position.y+30, self.text.color, 1, self.text.font, "center", "center")
    end;

    setName = function(self, name)
        self.name = name;
        return self.name;
    end;

    destroy = function(self)
        self = nil;
        return true;
    end;
});