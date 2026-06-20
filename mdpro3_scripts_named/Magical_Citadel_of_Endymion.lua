--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 魔法都市 恩底弥翁  (ID: 39910367)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 298
--
-- Effect Text:
-- ①：只要这张卡在场地区域存在，每次自己或者对方把魔法卡发动，给这张卡放置1个魔力指示物。
-- ②：有魔力指示物放置的卡被破坏的场合把那些卡放置的魔力指示物数量的魔力指示物给这张卡放置。
-- ③：1回合1次，自己为让卡的效果发动而把自己场上的魔力指示物取除的场合，可以作为代替从这张卡取除。
-- ④：这张卡被破坏的场合，可以作为代替把这张卡1个魔力指示物取除。
--[[ __CARD_HEADER_END__ ]]

--魔法都市エンディミオン
function c39910367.initial_effect(c)
	c:EnableCounterPermit(0x1)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Add counter
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetCode(EVENT_CHAIN_SOLVING)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_FZONE)
	e3:SetOperation(c39910367.op)
	c:RegisterEffect(e3)
	--Remove counter replace
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(39910367,0))
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_RCOUNTER_REPLACE+0x1)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c39910367.rcon)
	e4:SetOperation(c39910367.rop)
	c:RegisterEffect(e4)
	--Destroy replace
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_DESTROY_REPLACE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_FZONE)
	e5:SetTarget(c39910367.desreptg)
	e5:SetOperation(c39910367.desrepop)
	c:RegisterEffect(e5)
	--Add counter2
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e6:SetCode(EVENT_LEAVE_FIELD_P)
	e6:SetRange(LOCATION_FZONE)
	e6:SetOperation(c39910367.addop2)
	c:RegisterEffect(e6)
end
function c39910367.op(e,tp,eg,ep,ev,re,r,rp)
	local c=re:GetHandler()
	if re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL) and c~=e:GetHandler() then
		e:GetHandler():AddCounter(0x1,1)
	end
end
function c39910367.rcon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActivated() and bit.band(r,REASON_COST)~=0 and ep==e:GetOwnerPlayer() and e:GetHandler():GetCounter(0x1)>=ev
end
function c39910367.rop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RemoveCounter(ep,0x1,ev,REASON_EFFECT)
end
function c39910367.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReason(REASON_EFFECT+REASON_BATTLE) and not c:IsReason(REASON_REPLACE)
		and c:IsCanRemoveCounter(tp,0x1,1,REASON_EFFECT) end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c39910367.desrepop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RemoveCounter(tp,0x1,1,REASON_EFFECT)
end
function c39910367.addop2(e,tp,eg,ep,ev,re,r,rp)
	local count=0
	local c=eg:GetFirst()
	while c~=nil do
		if c~=e:GetHandler() and c:IsOnField() and c:IsReason(REASON_DESTROY) then
			count=count+c:GetCounter(0x1)
		end
		c=eg:GetNext()
	end
	if count>0 then
		e:GetHandler():AddCounter(0x1,count)
	end
end
