--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Neo Space  (ID: 42015635)
-- Type: Spell / Field
-- Setcode: 0x9
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Elemental HERO Neos" and all Fusion Monsters that mention "Elemental HERO Neos" as Fusion Material
-- gain 500 ATK.
-- Fusion Monsters that mention "Elemental HERO Neos" as Fusion Material do not have to activate their
-- effects during the End Phase that shuffle them into the Extra Deck.
--[[ __CARD_HEADER_END__ ]]

--ネオスペース
function c42015635.initial_effect(c)
	aux.AddCodeList(c,89943723)
	aux.AddSetNameMonsterList(c,0x3008)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c42015635.atktg)
	e2:SetValue(500)
	c:RegisterEffect(e2)
	--may not return
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(42015635)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	c:RegisterEffect(e3)
end
function c42015635.atktg(e,c)
	return c:IsCode(89943723) or c:IsType(TYPE_FUSION) and aux.IsMaterialListCode(c,89943723)
end
