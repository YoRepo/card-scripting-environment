--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 索菲娅之影灵衣  (ID: 21105106)
-- Type: Monster / Effect / Ritual
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 11
-- ATK 3600 | DEF 3400
-- Setcode: 180
--
-- Effect Text:
-- 「影灵衣」仪式魔法卡降临
-- 这张卡若非以使用各自种族不同的自己场上3只怪兽来作的从手卡的仪式召唤则不能特殊召唤。
-- ①：自己·对方的主要阶段1，从手卡把这张卡和1张「影灵衣」魔法卡丢弃才能发动。那次阶段内，对方不能从额外卡组把怪兽特殊召唤。
-- ②：这张卡仪式召唤时才能发动（这个效果发动的回合，自己不能把其他怪兽通常召唤·特殊召唤）。这张卡以外的双方的场上·墓地的卡全部除外。
--[[ __CARD_HEADER_END__ ]]

--sophiaの影霊衣
function c21105106.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c21105106.splimit)
	c:RegisterEffect(e1)
	--cannot spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c21105106.discon)
	e2:SetCost(c21105106.discost)
	e2:SetOperation(c21105106.disop)
	c:RegisterEffect(e2)
	--remove
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c21105106.rmcon)
	e3:SetCost(c21105106.rmcost)
	e3:SetTarget(c21105106.rmtg)
	e3:SetOperation(c21105106.rmop)
	c:RegisterEffect(e3)
end
function c21105106.splimit(e,se,sp,st)
	return e:GetHandler():IsLocation(LOCATION_HAND) and bit.band(st,SUMMON_TYPE_RITUAL)==SUMMON_TYPE_RITUAL
end
function c21105106.mat_filter(c,tp)
	return c:IsLocation(LOCATION_MZONE) and c:IsControler(tp)
end
function c21105106.discon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1
end
function c21105106.cfilter(c)
	return c:IsSetCard(0xb4) and c:IsType(TYPE_SPELL) and c:IsDiscardable()
end
function c21105106.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable()
		and Duel.IsExistingMatchingCard(c21105106.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g=Duel.SelectMatchingCard(tp,c21105106.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	g:AddCard(e:GetHandler())
	Duel.SendtoGrave(g,REASON_DISCARD+REASON_COST)
end
function c21105106.disop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_MAIN1)
	e1:SetTargetRange(0,1)
	e1:SetTarget(c21105106.sumlimit)
	Duel.RegisterEffect(e1,tp)
end
function c21105106.sumlimit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:IsLocation(LOCATION_EXTRA)
end
function c21105106.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_RITUAL)
end
function c21105106.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetActivityCount(tp,ACTIVITY_NORMALSUMMON)==0
		and Duel.GetActivityCount(tp,ACTIVITY_SPSUMMON)==1 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_SUMMON)
	Duel.RegisterEffect(e2,tp)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CANNOT_MSET)
	Duel.RegisterEffect(e3,tp)
end
function c21105106.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_ONFIELD+LOCATION_GRAVE,LOCATION_ONFIELD+LOCATION_GRAVE,1,e:GetHandler()) end
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_ONFIELD+LOCATION_GRAVE,LOCATION_ONFIELD+LOCATION_GRAVE,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c21105106.rmop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_ONFIELD+LOCATION_GRAVE,LOCATION_ONFIELD+LOCATION_GRAVE,aux.ExceptThisCard(e))
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end
function c21105106.mat_group_check(g)
	return #g==3 and g:GetClassCount(Card.GetRace)==3
end
