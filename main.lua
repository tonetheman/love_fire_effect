
local W = 800 -- width of screen default for love

local YPOS = 600 -- where the line is located

-- count of bullets
local COUNT = 1000

local bullets = {}

local colors = {
    { 0xb6, 0x22, 0x03 },
    { 0xd7, 0x35, 0x02 },
    { 0xfc, 0x64, 0x00 },
    { 0xff, 0x75, 0x00 },
    { 0xfa, 0xc0, 0x00 }
}

function new_bullet()
    return {
        x=love.math.random(1,W),
        y=YPOS,
        alive=true,
        radius = love.math.random(1,6),
        steps = love.math.random(60,240),
        color = love.math.random(1,#colors),
        speed = love.math.random(1,3)
    }
end

function regen_bullet(p)
    p.y=YPOS
    p.x = love.math.random(1,W)
    p.alive = true
    p.color = love.math.random(1,#colors)
end

function love.load()
    for i=1,COUNT do
        table.insert(bullets,new_bullet())
    end
end

function love.update(dt)
    for i,p in ipairs(bullets) do

        -- only here because there is no continue
        ::loop_top::

        -- move the bullet to the top of
        -- the screen
        p.y = p.y-p.speed

        -- kill the bullet
        if p.y<0 or love.math.random()<0.05 then
            p.alive = false
            
            -- fake continue
            goto loop_top
        end

        if p.alive == false then
            
            -- need to regenerate a new bullet
            if love.math.random()<0.5 then
                regen_bullet(p)
            end

        end
    end
end

function love.draw()
    for i,p in ipairs(bullets) do
        if p.alive then
            -- local c = colors[love.math.random(1,#colors)]
            love.graphics.setColor(love.math.colorFromBytes(
                colors[p.color][1], colors[p.color][2], colors[p.color][2])
            )
            love.graphics.circle("fill",p.x,p.y,p.radius)
        end
    end
end
