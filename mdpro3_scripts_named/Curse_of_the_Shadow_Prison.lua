--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 影牢之咒缚  (ID: 81788994)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：每次「影依」怪兽被效果送去墓地，每有1只给这张卡放置1个魔石指示物。
-- ②：对方场上的怪兽的攻击力在对方回合内下降这张卡的魔石指示物数量×100。
-- ③：每次自己把「影依」融合怪兽融合召唤有1次，可以把这张卡3个魔石指示物取除把对方场上1只表侧表示怪兽作为融合素材。
--[[ __CARD_HEADER_END__ ]]

--影牢の呪縛
function c81788994.initial_effect(c)
	c:EnableCounterPermit(0x16)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCondition(c81788994.ctcon)
	e2:SetOperation(c81788994.ctop)
	c:RegisterEffect(e2)
	--atkdown
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCondition(c81788994.atkcon)
	e3:SetValue(c81788994.atkval)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(81788994,0))
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCode(81788994)
	c:RegisterEffect(e4)
end
function c81788994.cfilter(c)
	return c:IsSetCard(0x9d) and c:IsType(TYPE_MONSTER) and c:IsReason(REASON_EFFECT)
end
function c81788994.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c81788994.cfilter,1,nil)
end
function c81788994.ctop(e,tp,eg,ep,ev,re,r,rp)
	local ct=eg:FilterCount(c81788994.cfilter,nil)
	e:GetHandler():AddCounter(0x16,ct)
end
function c81788994.atkcon(e)
	return Duel.GetTurnPlayer()~=e:GetHandlerPlayer()
end
function c81788994.atkval(e,c)
	return e:GetHandler():GetCounter(0x16)*-100
end
