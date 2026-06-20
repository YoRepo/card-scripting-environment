--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 次元吸引者  (ID: 91800273)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 6
-- ATK 1200 | DEF 2200
--
-- Effect Text:
-- ①：自己·对方回合，自己墓地没有卡存在的场合，把这张卡从手卡送去墓地才能发动。直到下个回合的结束时，被送去墓地的卡不去墓地而除外。
--[[ __CARD_HEADER_END__ ]]

--ディメンション・アトラクター
function c91800273.initial_effect(c)
	--redirect
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(91800273,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c91800273.redcon)
	e1:SetCost(c91800273.redcost)
	e1:SetTarget(c91800273.redtg)
	e1:SetOperation(c91800273.redop)
	c:RegisterEffect(e1)
end
function c91800273.redcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_GRAVE,0)==0
end
function c91800273.redcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c91800273.redtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,91800273)==0 end
end
function c91800273.redop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	e1:SetTargetRange(LOCATION_DECK,LOCATION_DECK)
	e1:SetValue(LOCATION_REMOVED)
	e1:SetReset(RESET_PHASE+PHASE_END,2)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,91800273,RESET_PHASE+PHASE_END,0,1)
end
