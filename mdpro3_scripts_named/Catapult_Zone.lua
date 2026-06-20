--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 投石区  (ID: 14289852)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：只要这张卡在场地区域存在，自己怪兽被战斗破坏的场合，可以作为代替从自己卡组把1只岩石族怪兽送去墓地。这个效果1回合只能适用1次。
--[[ __CARD_HEADER_END__ ]]

--岩投げエリア
function c14289852.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c14289852.destg)
	e2:SetValue(c14289852.value)
	e2:SetOperation(c14289852.desop)
	c:RegisterEffect(e2)
end
function c14289852.dfilter(c,tp)
	return c:IsControler(tp) and c:IsReason(REASON_BATTLE)
end
function c14289852.repfilter(c)
	return c:IsRace(RACE_ROCK) and c:IsAbleToGrave()
end
function c14289852.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c14289852.dfilter,1,nil,tp)
		and Duel.IsExistingMatchingCard(c14289852.repfilter,tp,LOCATION_DECK,0,1,nil) end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c14289852.value(e,c)
	return c:IsControler(e:GetHandlerPlayer()) and c:IsReason(REASON_BATTLE)
end
function c14289852.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c14289852.repfilter,tp,LOCATION_DECK,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_EFFECT)
end
