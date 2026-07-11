--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Beast Rage  (ID: 9999961)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- All monsters you control gain 200 ATK for each of your removed from play Beast-Type and Winged
-- Beast-Type monsters.
--[[ __CARD_HEADER_END__ ]]

--ビーストレイジ
function c9999961.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c9999961.target)
	e1:SetOperation(c9999961.activate)
	c:RegisterEffect(e1)
end
function c9999961.rfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_BEAST+RACE_WINDBEAST)
end
function c9999961.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c9999961.rfilter,tp,LOCATION_REMOVED,0,1,nil) end
end
function c9999961.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
	local atk=Duel.GetMatchingGroupCount(c9999961.rfilter,tp,LOCATION_REMOVED,0,nil)*200
	if g:GetCount()==0 or atk==0 then return end
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(atk)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
