--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Dragunity Tribus  (ID: 81962318)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Winged Beast
-- Level: 1
-- ATK 500 | DEF 300
-- Setcode: 0x29
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Normal or Special Summoned: You can send 1 Level 3 or lower Dragon monster from
-- your Deck to the GY.
--[[ __CARD_HEADER_END__ ]]

--ドラグニティ－トリブル
function c81962318.initial_effect(c)
	--send to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(81962318,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c81962318.target)
	e1:SetOperation(c81962318.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c81962318.tgfilter(c)
	return c:IsRace(RACE_DRAGON) and c:IsLevelBelow(3) and c:IsAbleToGrave()
end
function c81962318.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c81962318.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c81962318.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c81962318.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
