--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Wonder Xyz  (ID: 73860462)
-- Type: Trap
-- Setcode: 0x73
-- Scope: OCG / TCG
--
-- Effect Text:
-- Immediately after this effect resolves, Xyz Summon 1 Xyz Monster using monsters you control as
-- Materials.
--[[ __CARD_HEADER_END__ ]]

--ワンダー・エクシーズ
function c73860462.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetTarget(c73860462.xyztg)
	e1:SetOperation(c73860462.xyzop)
	c:RegisterEffect(e1)
end
function c73860462.xyzfilter(c)
	return c:IsXyzSummonable(nil)
end
function c73860462.xyztg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c73860462.xyzfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c73860462.xyzop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c73860462.xyzfilter,tp,LOCATION_EXTRA,0,nil)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=g:Select(tp,1,1,nil)
		Duel.XyzSummon(tp,tg:GetFirst(),nil)
	end
end
