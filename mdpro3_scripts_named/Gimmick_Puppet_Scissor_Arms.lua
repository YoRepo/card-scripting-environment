--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Gimmick Puppet Scissor Arms  (ID: 29216967)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level: 4
-- ATK 1200 | DEF 600
-- Setcode: 0x1083
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is Normal Summoned: You can send 1 "Gimmick Puppet" monster from your Deck to the GY.
--[[ __CARD_HEADER_END__ ]]

--ギミック・パペット－シザー・アーム
function c29216967.initial_effect(c)
	--send to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(29216967,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c29216967.target)
	e1:SetOperation(c29216967.operation)
	c:RegisterEffect(e1)
end
function c29216967.tgfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x1083) and c:IsAbleToGrave()
end
function c29216967.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c29216967.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c29216967.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c29216967.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
