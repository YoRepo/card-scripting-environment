--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Toon Briefcase  (ID: 5832914)
-- Type: Trap
-- Setcode: 0x62
-- Scope: OCG / TCG
--
-- Effect Text:
-- When your opponent Summons a monster(s) while you control a Toon monster: Shuffle that monster(s)
-- into the Deck.
--[[ __CARD_HEADER_END__ ]]

--トゥーンのかばん
function c5832914.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c5832914.condition)
	e1:SetTarget(c5832914.target)
	e1:SetOperation(c5832914.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c5832914.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_TOON)
end
function c5832914.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c5832914.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c5832914.filter(c,tp)
	return c:IsSummonPlayer(tp) and c:IsAbleToDeck()
end
function c5832914.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c5832914.filter,1,nil,1-tp) end
	local g=eg:Filter(c5832914.filter,nil,1-tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c5832914.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
end
