--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Orcustrated Einsatz  (ID: 62834295)
-- Type: Spell / Continuous
-- Setcode: 0x11b
-- Scope: OCG / TCG
--
-- Effect Text:
-- If your opponent Normal or Special Summons a monster(s) (except during the Damage Step): You can
-- take 1 "Orcust" or "World Legacy" monster from your hand or Deck, and either send it to the GY or
-- banish it.
-- You can only use this effect of "Orcustrated Einsatz" once per turn.
--[[ __CARD_HEADER_END__ ]]

--オルフェゴール・アインザッツ
function c62834295.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(62834295,0))
	e2:SetCategory(CATEGORY_TOGRAVE+CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,62834295)
	e2:SetCondition(c62834295.tgcon)
	e2:SetTarget(c62834295.tgtg)
	e2:SetOperation(c62834295.tgop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c62834295.cfilter(c,tp)
	return c:IsSummonPlayer(tp)
end
function c62834295.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c62834295.cfilter,1,nil,1-tp)
end
function c62834295.tgfilter(c)
	return c:IsSetCard(0xfe,0x11b) and c:IsType(TYPE_MONSTER) and (c:IsAbleToGrave() or c:IsAbleToRemove())
end
function c62834295.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c62834295.tgfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c62834295.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(62834295,1))
	local g=Duel.SelectMatchingCard(tp,c62834295.tgfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		if tc and tc:IsAbleToGrave() and (not tc:IsAbleToRemove() or Duel.SelectOption(tp,1191,1192)==0) then
			Duel.SendtoGrave(tc,REASON_EFFECT)
		else
			Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
		end
	end
end
