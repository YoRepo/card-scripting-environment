--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Blade Knight  (ID: 39507162)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 4
-- ATK 1600 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- Gains 400 ATK while you have 1 or less cards in your hand.
-- If you control no other monsters, the effects of Flip monsters destroyed by battle with this card
-- are negated.
--[[ __CARD_HEADER_END__ ]]

--ブレイドナイト
function c39507162.initial_effect(c)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(400)
	e1:SetCondition(c39507162.atkcon)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_BATTLED)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c39507162.discon)
	e2:SetOperation(c39507162.disop)
	c:RegisterEffect(e2)
end
function c39507162.atkcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_HAND,0)<=1
end
function c39507162.discon(e)
	return not Duel.IsExistingMatchingCard(nil,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
function c39507162.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc and bc:IsStatus(STATUS_BATTLE_DESTROYED) and bc:IsType(TYPE_FLIP) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x17a0000)
		bc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x17a0000)
		bc:RegisterEffect(e2)
	end
end
