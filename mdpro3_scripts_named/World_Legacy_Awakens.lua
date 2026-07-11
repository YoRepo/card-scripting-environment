--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: World Legacy Awakens  (ID: 12989604)
-- Type: Trap
-- Setcode: 0xfe
-- Scope: OCG / TCG
--
-- Effect Text:
-- Immediately after this effect resolves, Link Summon 1 Link Monster using monster(s) you control as
-- material.
-- You can only activate 1 "World Legacy Awakens" per turn.
--[[ __CARD_HEADER_END__ ]]

--星遺物からの目醒め
function c12989604.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,12989604+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c12989604.target)
	e1:SetOperation(c12989604.activate)
	c:RegisterEffect(e1)
end
function c12989604.filter(c)
	return c:IsLinkSummonable(nil)
end
function c12989604.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c12989604.filter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c12989604.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c12989604.filter,tp,LOCATION_EXTRA,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.LinkSummon(tp,tc,nil)
	end
end
