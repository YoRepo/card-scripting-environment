--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Earthbound Immortal Cusillu  (ID: 33537328)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Beast
-- Level: 10
-- ATK 2800 | DEF 2400
-- Setcode: 0x1021
-- Scope: OCG / TCG
--
-- Effect Text:
-- There can only be 1 "Earthbound Immortal" monster on the field.
-- If there is no face-up Field Spell on the field, destroy this card.
-- Your opponent's monsters cannot target this card for attacks.
-- This card can attack your opponent directly.
-- If this card would be destroyed by battle, you can Tribute 1 other monster instead, and if you do,
-- halve your opponent's LP.
--[[ __CARD_HEADER_END__ ]]

--地縛神 Cusillu
function c33537328.initial_effect(c)
	c:SetUniqueOnField(1,1,aux.FilterBoolFunction(Card.IsSetCard,0x1021),LOCATION_MZONE)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_SELF_DESTROY)
	e4:SetCondition(c33537328.sdcon)
	c:RegisterEffect(e4)
	--battle target
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetValue(aux.imval1)
	c:RegisterEffect(e5)
	--direct atk
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e6)
	--destroy replace
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCode(EFFECT_DESTROY_REPLACE)
	e7:SetTarget(c33537328.desreptg)
	c:RegisterEffect(e7)
end
function c33537328.sdcon(e)
	return not Duel.IsExistingMatchingCard(Card.IsFaceup,0,LOCATION_FZONE,LOCATION_FZONE,1,nil)
end
function c33537328.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReason(REASON_BATTLE) and c:GetBattlePosition()~=POS_FACEUP_DEFENSE
		and Duel.CheckReleaseGroupEx(tp,nil,1,REASON_EFFECT,false,c) end
	if Duel.SelectEffectYesNo(tp,c,96) then
		local g=Duel.SelectReleaseGroupEx(tp,nil,1,1,REASON_EFFECT,false,c)
		Duel.Release(g,REASON_EFFECT)
		Duel.SetLP(1-tp,math.ceil(Duel.GetLP(1-tp)/2))
		return true
	else return false end
end
