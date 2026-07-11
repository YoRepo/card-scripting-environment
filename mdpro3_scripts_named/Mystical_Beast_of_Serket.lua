--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Mystical Beast of Serket  (ID: 89194033)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fairy
-- Level: 6
-- ATK 2500 | DEF 2000
-- Setcode: 0x1c7
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you do not control "Temple of the Kings", destroy this card.
-- Banish any monster destroyed by battle with this card.
-- If this card destroys a monster by battle: It gains 500 ATK.
--[[ __CARD_HEADER_END__ ]]

--聖獣セルケト
function c89194033.initial_effect(c)
	aux.AddCodeList(c,29762407)
	--selfdestroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_SELF_DESTROY)
	e1:SetCondition(c89194033.descon)
	c:RegisterEffect(e1)
	--redirect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_BATTLE_DESTROY_REDIRECT)
	e2:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(89194033,0))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetCondition(c89194033.atkcon)
	e3:SetOperation(c89194033.atkop)
	c:RegisterEffect(e3)
end
function c89194033.desfilter(c)
	return c:IsFaceup() and c:IsCode(29762407)
end
function c89194033.descon(e)
	return not Duel.IsExistingMatchingCard(c89194033.desfilter,e:GetHandler():GetControler(),LOCATION_SZONE,0,1,nil)
end
function c89194033.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsFaceup() and e:GetHandler():IsRelateToBattle()
end
function c89194033.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(500)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
	c:RegisterEffect(e1)
end
