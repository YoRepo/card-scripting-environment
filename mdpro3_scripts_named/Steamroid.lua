--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Steamroid  (ID: 44729197)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level: 4
-- ATK 1800 | DEF 1800
-- Setcode: 0x16
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card attacks an opponent's monster, this card gains 500 ATK during the Damage Step only.
-- If this card is attacked by an opponent's monster, this card loses 500 ATK during the Damage Step
-- only.
--[[ __CARD_HEADER_END__ ]]

--スチームロイド
function c44729197.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(c44729197.condtion)
	e1:SetValue(c44729197.val)
	c:RegisterEffect(e1)
end
function c44729197.condtion(e)
	local ph=Duel.GetCurrentPhase()
	return ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL
end
function c44729197.val(e,c)
	if Duel.GetAttacker()==e:GetHandler() and Duel.GetAttackTarget()~=nil then return 500
	elseif e:GetHandler()==Duel.GetAttackTarget() then return -500
	else return 0 end
end
