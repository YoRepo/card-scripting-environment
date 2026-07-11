--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Scarlet Security  (ID: 50215517)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a "Red Dragon Archfiend": Destroy all Spells/Traps your opponent controls.
--[[ __CARD_HEADER_END__ ]]

--クリムゾン・ヘル・セキュア
function c50215517.initial_effect(c)
	aux.AddCodeList(c,70902743)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c50215517.condition)
	e1:SetTarget(c50215517.target)
	e1:SetOperation(c50215517.activate)
	c:RegisterEffect(e1)
end
function c50215517.cfilter(c)
	return c:IsFaceup() and c:IsCode(70902743)
end
function c50215517.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c50215517.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c50215517.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c50215517.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c50215517.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	local sg=Duel.GetMatchingGroup(c50215517.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c50215517.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c50215517.filter,tp,0,LOCATION_ONFIELD,aux.ExceptThisCard(e))
	Duel.Destroy(sg,REASON_EFFECT)
end
