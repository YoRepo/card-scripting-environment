--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Steelswarm Cell  (ID: 54338958)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 1
-- ATK 0 | DEF 0
-- Setcode: 0x100a
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control no monsters, you can Special Summon this card (from your hand).
-- While this card is face-up on the field, it cannot be Tributed, except for the Tribute Summon of a
-- "Steelswarm" monster, and cannot be used as a Synchro Material Monster.
--[[ __CARD_HEADER_END__ ]]

--インヴェルズの魔細胞
function c54338958.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c54338958.spcon)
	c:RegisterEffect(e1)
	--cannot release
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UNRELEASABLE_SUM)
	e3:SetValue(c54338958.sumlimit)
	c:RegisterEffect(e3)
	--cannot be synchro material
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e4:SetValue(1)
	c:RegisterEffect(e4)
end
function c54338958.spcon(e,c)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)==0
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c54338958.sumlimit(e,c)
	return not c:IsSetCard(0x100a)
end
