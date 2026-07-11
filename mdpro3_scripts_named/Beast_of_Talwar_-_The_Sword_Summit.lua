--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Beast of Talwar - The Sword Summit  (ID: 20011655)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 7
-- ATK 2400 | DEF 2150
-- Setcode: 0x45
-- Scope: OCG / TCG
--
-- Effect Text:
-- (This card is always treated as an "Archfiend" card.)
-- If you control no monsters, you can Special Summon this card (from your hand).
-- The first time this card would be destroyed by an opponent's card effect each turn, it is not
-- destroyed.
-- Neither player can target other monsters with Equip Spell Cards or effects.
--[[ __CARD_HEADER_END__ ]]

--魔剣達士－タルワール・デーモン
local s,id,o=GetID()
function s.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(s.hspcon)
	c:RegisterEffect(e1)
	--indestructible
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(s.indct)
	--cannot target
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0x34,0x34)
	e3:SetTarget(s.tglimit)
	e3:SetValue(s.tgoval)
	c:RegisterEffect(e3)
end
function s.hspcon(e,c)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)==0
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function s.indct(e,re,r,rp)
	if r&REASON_EFFECT>0 and e:GetOwnerPlayer()~=rp then
		return 1
	else return 0 end
end
function s.tglimit(e,c)
	return c~=e:GetHandler() and c:IsType(TYPE_MONSTER)
end
function s.tgoval(e,re,rp)
	return re:IsActiveType(TYPE_SPELL) and re:GetHandler():IsType(TYPE_EQUIP)
end
