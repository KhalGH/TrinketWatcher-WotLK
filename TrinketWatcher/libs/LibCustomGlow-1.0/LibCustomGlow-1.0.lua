-- Required Code
local assert = assert
local ipairs = ipairs
local next = next
local pairs = pairs
local select = select

local function Mixin(object, ...)
	for i = 1, select("#", ...) do
		local mixin = select(i, ...);
		for k, v in pairs(mixin) do
			object[k] = v;
		end
	end

	return object;
end

local function CreateFromMixins(...)
	return Mixin({}, ...)
end

local function nop()
end

ObjectPoolMixin = {};

function ObjectPoolMixin:OnLoad(creationFunc, resetterFunc)
	self.creationFunc = creationFunc;
	self.resetterFunc = resetterFunc;

	self.activeObjects = {};
	self.inactiveObjects = {};

	self.numActiveObjects = 0;
end

function ObjectPoolMixin:Acquire()
	local numInactiveObjects = #self.inactiveObjects;
	if numInactiveObjects > 0 then
		local obj = self.inactiveObjects[numInactiveObjects];
		self.activeObjects[obj] = true;
		self.numActiveObjects = self.numActiveObjects + 1;
		self.inactiveObjects[numInactiveObjects] = nil;
		return obj, false;
	end

	local newObj = self.creationFunc(self);
	if self.resetterFunc then
		self.resetterFunc(self, newObj);
	end
	self.activeObjects[newObj] = true;
	self.numActiveObjects = self.numActiveObjects + 1;
	return newObj, true;
end

function ObjectPoolMixin:Release(obj)
	if self:IsActive(obj) then
		self.inactiveObjects[#self.inactiveObjects + 1] = obj;
		self.activeObjects[obj] = nil;
		self.numActiveObjects = self.numActiveObjects - 1;
		if self.resetterFunc then
			self.resetterFunc(self, obj);
		end

		return true;
	end

	return false;
end

function ObjectPoolMixin:ReleaseAll()
	for obj in pairs(self.activeObjects) do
		self:Release(obj);
	end
end

function ObjectPoolMixin:EnumerateActive()
	return pairs(self.activeObjects);
end

function ObjectPoolMixin:GetNextActive(current)
	return (next(self.activeObjects, current));
end

function ObjectPoolMixin:IsActive(object)
	return (self.activeObjects[object] ~= nil);
end

function ObjectPoolMixin:GetNumActive()
	return self.numActiveObjects;
end

function ObjectPoolMixin:EnumerateInactive()
	return ipairs(self.inactiveObjects);
end

function CreateObjectPool(creationFunc, resetterFunc)
	local objectPool = CreateFromMixins(ObjectPoolMixin);
	objectPool:OnLoad(creationFunc, resetterFunc);
	return objectPool;
end

FramePoolMixin = CreateFromMixins(ObjectPoolMixin);

local function FramePoolFactory(framePool)
	return CreateFrame(framePool.frameType, nil, framePool.parent, framePool.frameTemplate);
end

local function ForbiddenFramePoolFactory(framePool)
	return CreateForbiddenFrame(framePool.frameType, nil, framePool.parent, framePool.frameTemplate);
end

function FramePoolMixin:OnLoad(frameType, parent, frameTemplate, resetterFunc, forbidden)
	if forbidden then
		ObjectPoolMixin.OnLoad(self, ForbiddenFramePoolFactory, resetterFunc);
	else
		ObjectPoolMixin.OnLoad(self, FramePoolFactory, resetterFunc);
	end
	self.frameType = frameType;
	self.parent = parent;
	self.frameTemplate = frameTemplate;
end

function FramePoolMixin:GetTemplate()
	return self.frameTemplate;
end

function FramePool_Hide(framePool, frame)
	frame:Hide();
end

function FramePool_HideAndClearAnchors(framePool, frame)
	frame:Hide();
	frame:ClearAllPoints();
end

function CreateFramePool(frameType, parent, frameTemplate, resetterFunc, forbidden)
	local framePool = CreateFromMixins(FramePoolMixin);
	framePool:OnLoad(frameType, parent, frameTemplate, resetterFunc or FramePool_HideAndClearAnchors, forbidden);
	return framePool;
end

TexturePoolMixin = CreateFromMixins(ObjectPoolMixin);

local function TexturePoolFactory(texturePool)
	return texturePool.parent:CreateTexture(nil, texturePool.layer, texturePool.textureTemplate);
end

function TexturePoolMixin:OnLoad(parent, layer, textureTemplate, resetterFunc)
	ObjectPoolMixin.OnLoad(self, TexturePoolFactory, resetterFunc);
	self.parent = parent;
	self.layer = layer;
	self.textureTemplate = textureTemplate;
end

TexturePool_Hide = FramePool_Hide;
TexturePool_HideAndClearAnchors = FramePool_HideAndClearAnchors;

function CreateTexturePool(parent, layer, textureTemplate, resetterFunc)
	local texturePool = CreateFromMixins(TexturePoolMixin);
	texturePool:OnLoad(parent, layer, textureTemplate, resetterFunc or TexturePool_HideAndClearAnchors);
	return texturePool;
end

FontStringPoolMixin = CreateFromMixins(ObjectPoolMixin);

local function FontStringPoolFactory(fontStringPool)
	return fontStringPool.parent:CreateFontString(nil, fontStringPool.layer, fontStringPool.fontStringTemplate);
end

function FontStringPoolMixin:OnLoad(parent, layer, fontStringTemplate, resetterFunc)
	ObjectPoolMixin.OnLoad(self, FontStringPoolFactory, resetterFunc);
	self.parent = parent;
	self.layer = layer;
	self.fontStringTemplate = fontStringTemplate;
end

FontStringPool_Hide = FramePool_Hide;
FontStringPool_HideAndClearAnchors = FramePool_HideAndClearAnchors;

function CreateFontStringPool(parent, layer, fontStringTemplate, resetterFunc)
	local fontStringPool = CreateFromMixins(FontStringPoolMixin);
	fontStringPool:OnLoad(parent, layer, fontStringTemplate, resetterFunc or FontStringPool_HideAndClearAnchors);
	return fontStringPool;
end

ActorPoolMixin = CreateFromMixins(ObjectPoolMixin);

local function ActorPoolFactory(actorPool)
	return actorPool.parent:CreateActor(nil, actorPool.actorTemplate);
end

function ActorPoolMixin:OnLoad(parent, actorTemplate, resetterFunc)
	ObjectPoolMixin.OnLoad(self, ActorPoolFactory, resetterFunc);
	self.parent = parent;
	self.actorTemplate = actorTemplate;
end

ActorPool_Hide = FramePool_Hide;
function ActorPool_HideAndClearModel(actorPool, actor)
	actor:ClearModel();
	actor:Hide();
end

function CreateActorPool(parent, actorTemplate, resetterFunc)
	local actorPool = CreateFromMixins(ActorPoolMixin);
	actorPool:OnLoad(parent, actorTemplate, resetterFunc or ActorPool_HideAndClearModel);
	return actorPool;
end

FramePoolCollectionMixin = {};

function CreateFramePoolCollection()
	local poolCollection = CreateFromMixins(FramePoolCollectionMixin);
	poolCollection:OnLoad();
	return poolCollection;
end

function FramePoolCollectionMixin:OnLoad()
	self.pools = {};
end

function FramePoolCollectionMixin:GetNumActive()
	local numTotalActive = 0;
	for _, pool in pairs(self.pools) do
		numTotalActive = numTotalActive + pool:GetNumActive();
	end
	return numTotalActive;
end

function FramePoolCollectionMixin:GetOrCreatePool(frameType, parent, template, resetterFunc, forbidden)
	local pool = self:GetPool(template);
	if not pool then
		pool = self:CreatePool(frameType, parent, template, resetterFunc, forbidden);
	end
	return pool;
end

function FramePoolCollectionMixin:CreatePool(frameType, parent, template, resetterFunc, forbidden)
	assert(self:GetPool(template) == nil);
	local pool = CreateFramePool(frameType, parent, template, resetterFunc, forbidden);
	self.pools[template] = pool;
	return pool;
end

function FramePoolCollectionMixin:GetPool(template)
	return self.pools[template];
end

function FramePoolCollectionMixin:Acquire(template)
	local pool = self:GetPool(template);
	assert(pool);
	return pool:Acquire();
end

function FramePoolCollectionMixin:Release(object)
	for _, pool in pairs(self.pools) do
		if pool:Release(object) then
			-- Found it! Just return
			return;
		end
	end

	-- Huh, we didn't find that object
	assert(false);
end

function FramePoolCollectionMixin:ReleaseAllByTemplate(template)
	local pool = self:GetPool(template);
	if pool then
		pool:ReleaseAll();
	end
end

function FramePoolCollectionMixin:ReleaseAll()
	for key, pool in pairs(self.pools) do
		pool:ReleaseAll();
	end
end

function FramePoolCollectionMixin:EnumerateActiveByTemplate(template)
	local pool = self:GetPool(template);
	if pool then
		return pool:EnumerateActive();
	end

	return nop;
end

function FramePoolCollectionMixin:EnumerateActive()
	local currentPoolKey, currentPool = next(self.pools, nil);
	local currentObject = nil;
	return function()
		if currentPool then
			currentObject = currentPool:GetNextActive(currentObject);
			while not currentObject do
				currentPoolKey, currentPool = next(self.pools, currentPoolKey);
				if currentPool then
					currentObject = currentPool:GetNextActive();
				else
					break;
				end
			end
		end

		return currentObject;
	end, nil;
end

FixedSizeFramePoolCollectionMixin = CreateFromMixins(FramePoolCollectionMixin);

function CreateFixedSizeFramePoolCollection()
	local poolCollection = CreateFromMixins(FixedSizeFramePoolCollectionMixin);
	poolCollection:OnLoad();
	return poolCollection;
end

function FixedSizeFramePoolCollectionMixin:OnLoad()
	FramePoolCollectionMixin.OnLoad(self);
	self.sizes = {};
end

function FixedSizeFramePoolCollectionMixin:CreatePool(frameType, parent, template, resetterFunc, forbidden, maxPoolSize, preallocate)
	local pool = FramePoolCollectionMixin.CreatePool(self, frameType, parent, template, resetterFunc, forbidden);

	if preallocate then
		for i = 1, maxPoolSize do
			pool:Acquire();
		end
		pool:ReleaseAll();
	end

	self.sizes[template] = maxPoolSize;

	return pool;
end

function FixedSizeFramePoolCollectionMixin:Acquire(template)
	local pool = self:GetPool(template);
	assert(pool);

	if pool:GetNumActive() < self.sizes[template] then
		return pool:Acquire();
	end
	return nil;
end

--

local MAJOR_VERSION = "LibCustomGlow-1.0"
local MINOR_VERSION = 15
if not LibStub then error(MAJOR_VERSION .. " requires LibStub.") end
local lib, oldversion = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not lib then return end

local pairs, ipairs = pairs, ipairs
local ceil, floor, min, mod = math.ceil, math.floor, math.min, mod
local tinsert, tremove = table.insert, table.remove


local textureList = {
	["empty"] = [[Interface\AddOns\KhalAuras\Libs\LibCustomGlow-1.0\AM_29]],
	["white"] = [[Interface\BUTTONS\WHITE8X8]],
	["shine"] = [[Interface\AddOns\KhalAuras\Libs\LibCustomGlow-1.0\Artifacts]]
}

function lib.RegisterTextures(texture, id)
	textureList[id] = texture
end

lib.glowList = {}
lib.startList = {}
lib.stopList = {}

local GlowParent = UIParent

local TexPoolResetter = function(pool, tex)
	tex:Hide()
	tex:ClearAllPoints()
end
local GlowTexPool = CreateTexturePool(GlowParent, "ARTWORK", nil, TexPoolResetter)
lib.GlowTexPool = GlowTexPool

local FramePoolResetter = function(framePool, frame)
	frame:SetScript("OnSizeChanged", nil)
	frame:SetScript("OnUpdate", nil)

	local parent = frame:GetParent()
	if parent[frame.name] then
		parent[frame.name] = nil
	end

	if frame.textures then
		for _, texture in ipairs(frame.textures) do
			GlowTexPool:Release(texture)
		end
	end

	frame.textures = {}
	frame.info = {}
	frame.name = nil
	frame.timer = nil
	frame:Hide()
	frame:ClearAllPoints()
end

local GlowFramePool = CreateFramePool("Frame", GlowParent, nil, FramePoolResetter)
lib.GlowFramePool = GlowFramePool

local function addFrameAndTex(r, color, name, key, N, xOffset, yOffset, texture, texCoord, desaturated, frameLevel)
	key = key or ""
	frameLevel = frameLevel or 8

	if not r[name..key] then
		r[name..key] = GlowFramePool:Acquire()
		r[name..key]:SetParent(r)
		r[name..key].name = name..key
	end

	local f = r[name..key]
	f:SetFrameLevel(r:GetFrameLevel() + frameLevel)
	f:SetPoint("TOPLEFT", r, "TOPLEFT", -xOffset, yOffset)
	f:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT", xOffset, -yOffset)
	f:Show()

	if not f.textures then
		f.textures = {}
	end

	for i = 1, N do
		if not f.textures[i] then
			f.textures[i] = GlowTexPool:Acquire()
			f.textures[i]:SetTexture(texture)
			f.textures[i]:SetTexCoord(texCoord[1], texCoord[2], texCoord[3], texCoord[4])
			f.textures[i]:SetParent(f)
		end

		f.textures[i]:SetVertexColor(color[1], color[2], color[3], color[4])
		f.textures[i]:Show()
	end

	while #f.textures > N do
		GlowTexPool:Release(f.textures[#f.textures])
		tremove(f.textures)
	end
end


--Pixel Glow Functions--
local pPoint = {
	["BOTTOMLEFT"] = "BOTTOMRIGHT",
	["BOTTOMRIGHT"] = "TOPRIGHT",
	["TOPRIGHT"] = "TOPLEFT",
	["TOPLEFT"] = "BOTTOMLEFT",
}

local function pWidth(position, width, length, thickness, line1, line2, point)
	line1:ClearAllPoints()
	line1:SetPoint(pPoint[point], point == "BOTTOMLEFT" and -position or position, 0)
	position = width - position
	if position > length then
		line1:SetSize(length, thickness)
		line2:Hide()
	else
		line2:ClearAllPoints()
		line2:SetPoint(point)
		line2:Show()

		line1:SetSize(position, thickness)
		line2:SetSize(thickness, length - position)
	end
end

local function pHeight(position, height, length, thickness, line1, line2, point)
	line1:ClearAllPoints()
	line1:SetPoint(pPoint[point], 0, point == "BOTTOMRIGHT" and -position or position)
	position = height - position
	if position > length then
		line1:SetSize(thickness, length)
		line2:Hide()
	else
		line2:ClearAllPoints()
		line2:SetPoint(point)
		line2:Show()

		line1:SetSize(thickness, position)
		line2:SetSize(length - position, thickness)
	end
end

local function pSizeChanged(self, width, height)
	if not (width or height) then
		width, height = self:GetSize()
	end

	if width ~= self.info.width or height ~= self.info.height then
		self.info.width = width
		self.info.height = height
		self.info.perimeter = 2 * (width + height)
		self.info.bottomlim = height * 2 + width
		self.info.rightlim = height + width
		self.info.space = self.info.perimeter / self.info.N
	end
end

local function pUpdate(self, elapsed)
	self.timer = self.timer + elapsed / self.info.period
	if self.timer > 1 or self.timer < -1 then
		self.timer = self.timer % 1
	end

	local info = self.info
	for i = 1, info.N do
		local position = (info.space * i + info.perimeter * self.timer) % info.perimeter
		if position > info.bottomlim then -- BOTTOM
			pWidth(position - info.bottomlim, info.width, info.length, info.th, self.textures[i], self.textures[info.N + i], "BOTTOMLEFT")
		elseif position > info.rightlim then -- RIGHT
			pHeight(position - info.rightlim, info.height, info.length, info.th, self.textures[i], self.textures[info.N + i], "BOTTOMRIGHT")
		elseif position > info.height then -- TOP
			pWidth(position - info.height, info.width, info.length, info.th, self.textures[i], self.textures[info.N + i], "TOPRIGHT")
		else -- LEFT
			pHeight(position, info.height, info.length, info.th, self.textures[i], self.textures[info.N + i], "TOPLEFT")
		end
	end
end

function lib.PixelGlow_Start(r, color, N, frequency, length, th, xOffset, yOffset, border, key, frameLevel)
	if not r then return end
	if not N or N <= 0 then N = 8 end

	local width, height = r:GetSize()
	length = length or floor((width + height) * (2 / N - 0.1))
	length = min(length, min(width, height))
	key = key or ""

	addFrameAndTex(r, color or {.95, .95, .32, 1}, "_PixelGlow", key, N * 2, xOffset or 0, yOffset or 0, textureList.white, {0, 1, 0, 1}, nil, frameLevel)

	local f = r["_PixelGlow"..key]

	f.timer = f.timer or 0
	f.info = f.info or {}
	f.info.N = N
	f.info.period = (not frequency or frequency == 0) and 4 or (1 / frequency)
	f.info.th = th or 1

	if f.info.length ~= length then
		f.info.width = nil
		f.info.length = length
	end

	pSizeChanged(f)
	f:SetScript("OnSizeChanged", pSizeChanged)
	f:SetScript("OnUpdate", pUpdate)
end

function lib.PixelGlow_Stop(r, key)
	if not r then return end
	key = key or ""
	if not r["_PixelGlow"..key] then
		return false
	else
		GlowFramePool:Release(r["_PixelGlow"..key])
	end
end

tinsert(lib.glowList, "Pixel Glow")
lib.startList["Pixel Glow"] = lib.PixelGlow_Start
lib.stopList["Pixel Glow"] = lib.PixelGlow_Stop


--Autocast Glow Funcitons--
local acSizes = {7, 6, 5, 4}

local function acSizeChanged(self, width, height)
	if not (width or height) then
		width, height = self:GetSize()
	end

	if width ~= self.info.width or height ~= self.info.height then
		self.info.width = width
		self.info.height = height
		self.info.perimeter = 2 * (width + height)
		self.info.bottomlim = height * 2 + width
		self.info.rightlim = height + width
		self.info.space = self.info.perimeter / self.info.N
	end
end

local function acUpdate(self, elapsed)
	local texIndex, info = 0, self.info
	for k = 1, 4 do
		self.timer[k] = self.timer[k] + elapsed / (info.period * k)
		if self.timer[k] > 1 or self.timer[k] < -1 then
			self.timer[k] = self.timer[k] % 1
		end
		for i = 1, info.N do
			texIndex = texIndex + 1
			local position = (info.space * i + info.perimeter * self.timer[k]) % info.perimeter
			if position > info.bottomlim then
				self.textures[texIndex]:SetPoint("CENTER", self, "BOTTOMRIGHT", -position + info.bottomlim, 0)
			elseif position > info.rightlim then
				self.textures[texIndex]:SetPoint("CENTER", self, "TOPRIGHT", 0, -position + info.rightlim)
			elseif position > info.height then
				self.textures[texIndex]:SetPoint("CENTER", self, "TOPLEFT", position - info.height, 0)
			else
				self.textures[texIndex]:SetPoint("CENTER", self, "BOTTOMLEFT", 0, position)
			end
		end
	end
end

function lib.AutoCastGlow_Start(r, color, N, frequency, scale, xOffset, yOffset, key, frameLevel)
	if not r then return end
	if not (N and N > 0) then N = 4 end

	scale = scale or 1
	xOffset = xOffset or 0
	yOffset = yOffset or 0
	key = key or ""

	addFrameAndTex(r, color or {.95, .95, .32, 1}, "_AutoCastGlow", key, N * 4, xOffset, yOffset, textureList.shine, {0.8115234375, 0.9169921875, 0.8798828125, 0.9853515625}, true, frameLevel)
	local f = r["_AutoCastGlow"..key]
	for k, size in pairs(acSizes) do
		for i = 1, N do
			f.textures[i + N * (k - 1)]:SetSize(size * scale, size * scale)
		end
	end

	f.timer = f.timer or {0, 0, 0, 0}
	f.info = f.info or {}
	f.info.N = N
	f.info.period = (not frequency or frequency == 0) and 4 or (1 / frequency)

	acSizeChanged(f)
	f:SetScript("OnSizeChanged", acSizeChanged)
	f:SetScript("OnUpdate", acUpdate)
end

function lib.AutoCastGlow_Stop(r, key)
	if not r then return end

	key = key or ""
	if not r["_AutoCastGlow"..key] then
		return false
	else
		GlowFramePool:Release(r["_AutoCastGlow"..key])
	end
end

tinsert(lib.glowList, "Autocast Shine")
lib.startList["Autocast Shine"] = lib.AutoCastGlow_Start
lib.stopList["Autocast Shine"] = lib.AutoCastGlow_Stop

--Action Button Glow--
local function ButtonGlowResetter(framePool,frame)
	--	frame:SetScript("OnUpdate",nil)
	local parent = frame:GetParent()
	if parent._ButtonGlow then
		parent._ButtonGlow = nil
	end
	frame:Hide()
	frame:ClearAllPoints()
end
local ButtonGlowPool = CreateFramePool("Frame", GlowParent, nil, ButtonGlowResetter)
lib.ButtonGlowPool = ButtonGlowPool

local function AnimateTexCoords(texture, textureWidth, textureHeight, frameWidth, frameHeight, numFrames, elapsed, throttle)
	if not texture.frame then
		texture.frame = 1
		texture.throttle = throttle
		texture.numColumns = floor(textureWidth / frameWidth)
		texture.numRows = floor(textureHeight / frameHeight)
		texture.columnWidth = frameWidth / textureWidth
		texture.rowHeight = frameHeight / textureHeight
	end

	if not texture.throttle or texture.throttle > throttle then
		local frame = texture.frame
		local framesToAdvance = floor(texture.throttle / throttle)
		while frame + framesToAdvance > numFrames do
			frame = frame - numFrames
		end

		frame = frame + framesToAdvance
		texture.throttle = 0

		local left = mod(frame - 1, texture.numColumns) * texture.columnWidth
		local right = left + texture.columnWidth
		local bottom = ceil(frame / texture.numColumns) * texture.rowHeight
		local top = bottom - texture.rowHeight
		texture:SetTexCoord(left, right, top, bottom)

		texture.frame = frame
	else
		texture.throttle = texture.throttle + elapsed
	end
end

local function bgUpdate(self, elapsed)
	AnimateTexCoords(self.ants, 256, 256, 48, 48, 22, elapsed, self.throttle)
end

local function bgHide(self)
	ButtonGlowPool:Release(self)
end

local function configureButtonGlow(f, alpha)
	-- outer glow
	f.outerGlow = f:CreateTexture()
	f.outerGlow:SetPoint("CENTER")
	f.outerGlow:SetTexture([[Interface\AddOns\KhalAuras\Libs\LibCustomGlow-1.0\IconAlert]])
	f.outerGlow:SetTexCoord(0.00781250, 0.50781250, 0.27734375, 0.52734375)

	-- ants
	f.ants = f:CreateTexture(nil, "OVERLAY")
	f.ants:SetPoint("CENTER")
	f.ants:SetTexture([[Interface\AddOns\KhalAuras\Libs\LibCustomGlow-1.0\IconAlertAnts]])
	f.ants:SetTexCoord(0.375, 0.5625, 0, 0.1875)

	f:SetScript("OnUpdate", bgUpdate)
	--f:SetScript("OnHide", bgHide)
end

local ButtonGlowTextures = {["outerGlow"] = true, ["ants"] = true}

function lib.ButtonGlow_Start(r, color, frequency, frameLevel)
	if not r then return end
	frameLevel = frameLevel or 8;
	local throttle = frequency and frequency > 0 and 0.25 / frequency * 0.01 or 0.01

	if not r._ButtonGlow then
		local f, new = ButtonGlowPool:Acquire()
		if new then
			configureButtonGlow(f,color and color[4] or 1)
		end
		r._ButtonGlow = f

		local width, height = r:GetSize()
		f:SetParent(r)
		f:SetFrameLevel(r:GetFrameLevel() + frameLevel)
		f:SetSize(width * 1.4, height * 1.4)
		f:SetPoint("TOPLEFT", r, "TOPLEFT", -width * 0.2, height * 0.2)
		f:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT", width * 0.2, -height * 0.2)
		f:Show()
		f.outerGlow:SetSize(width * 1.4, height * 1.4)
		f.ants:SetSize(width * 0.85 * 1.4, height * 0.85 * 1.4)	

		if not color then
			f.color = false
			for texture in pairs(ButtonGlowTextures) do
				f[texture]:SetVertexColor(1, 1, 1)
			end
		else
			f.color = color
			for texture in pairs(ButtonGlowTextures) do
				f[texture]:SetVertexColor(color[1], color[2], color[3])
			end
		end
		f.throttle = throttle
	end
end

function lib.ButtonGlow_Stop(r)
	if r and r._ButtonGlow then
		ButtonGlowPool:Release(r._ButtonGlow)
		--r._ButtonGlow:Hide()
	end
end

tinsert(lib.glowList, "Action Button Glow")
lib.startList["Action Button Glow"] = lib.ButtonGlow_Start
lib.stopList["Action Button Glow"] = lib.ButtonGlow_Stop