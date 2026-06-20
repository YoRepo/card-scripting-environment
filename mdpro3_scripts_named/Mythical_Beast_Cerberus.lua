--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 魔导兽 刻耳柏洛斯  (ID: 55424270)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 4
-- ATK 1400 | DEF 1400
-- Setcode: 269
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域存在，每次自己或对方把魔法卡发动，给这张卡放置1个魔力指示物。
-- ②：这张卡的攻击力上升这张卡的魔力指示物数量×500。
-- ③：这张卡进行战斗的战斗阶段结束时这张卡的魔力指示物全部取除。
--[[ __CARD_HEADER_END__ ]]

--魔導獣 ケルベロス
function c55424270.initial_effect(c)
	c:EnableCounterPermit(0x1)
	--add counter
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e0:SetCode(EVENT_CHAINING)
	e0:SetRange(LOCATION_MZONE)
	e0:SetOperation(aux.chainreg)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetCode(EVENT_CHAIN_SOLVED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c55424270.acop)
	c:RegisterEffect(e1)
	--attackup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c55424270.attackup)
	c:RegisterEffect(e2)
	--remove counter
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c55424270.condition)
	e3:SetOperation(c55424270.operation)
	c:RegisterEffect(e3)
end
function c55424270.acop(e,tp,eg,ep,ev,re,r,rp)
	if re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL) and e:GetHandler():GetFlagEffect(FLAG_ID_CHAINING)>0 then
		e:GetHandler():AddCounter(0x1,1)
	end
end
function c55424270.attackup(e,c)
	return c:GetCounter(0x1)*500
end
function c55424270.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattledGroupCount()>0
end
function c55424270.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local n=c:GetCounter(0x1)
	if n~=0 then c:RemoveCounter(tp,0x1,n,REASON_EFFECT) end
end
