--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Ganbara Knight  (ID: 24291651)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 4
-- ATK 0 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this face-up Attack Position card is targeted for an attack: You can change it to Defense
-- Position.
--[[ __CARD_HEADER_END__ ]]

--ガンバラナイト
function c24291651.initial_effect(c)
	--to defense
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(24291651,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c24291651.poscon)
	e1:SetOperation(c24291651.posop)
	c:RegisterEffect(e1)
end
function c24291651.poscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsAttackPos()
end
function c24291651.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
end
