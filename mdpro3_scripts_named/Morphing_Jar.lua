--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Morphing Jar  (ID: 33508719)
-- Type: Monster / Effect / Flip
-- Attribute: EARTH
-- Race: Rock
-- Level: 2
-- ATK 700 | DEF 600
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: Both players discard as many cards as possible from their hands, then each player draws 5
-- cards.
--[[ __CARD_HEADER_END__ ]]

--メタモルポット
function c33508719.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_HANDES_SELF+CATEGORY_HANDES_OPPO+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c33508719.target)
	e1:SetOperation(c33508719.operation)
	c:RegisterEffect(e1)
end
function c33508719.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_HANDES_SELF,nil,0,tp,0)
	Duel.SetOperationInfo(0,CATEGORY_HANDES_OPPO,nil,0,1-tp,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,PLAYER_ALL,5)
end
function c33508719.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,LOCATION_HAND)
	if g:GetCount()>0 then Duel.SendtoGrave(g,REASON_DISCARD+REASON_EFFECT) end
	Duel.BreakEffect()
	Duel.Draw(tp,5,REASON_EFFECT)
	Duel.Draw(1-tp,5,REASON_EFFECT)
end
