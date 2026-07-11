--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Worm Dimikles  (ID: 88438982)
-- Type: Monster / Effect / Flip
-- Attribute: LIGHT
-- Race: Reptile
-- Level: 4
-- ATK 1700 | DEF 1400
-- Setcode: 0x3e
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: This card gains 300 ATK and DEF.
--[[ __CARD_HEADER_END__ ]]

--ワーム・ディミクレス
function c88438982.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FLIP+EFFECT_TYPE_SINGLE)
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetOperation(c88438982.adop)
	c:RegisterEffect(e1)
end
function c88438982.adop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(300)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		c:RegisterEffect(e2)
	end
end
