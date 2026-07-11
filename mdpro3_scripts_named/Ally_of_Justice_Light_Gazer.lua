--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Ally of Justice Light Gazer  (ID: 19204398)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Machine
-- Level: 8
-- ATK 2400 | DEF 1600
-- Setcode: 0x1
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Tuner + 1 or more non-Tuner monsters
-- This card gains 200 ATK for each LIGHT monster in your opponent's Graveyard.
--[[ __CARD_HEADER_END__ ]]

--A・O・J ライト・ゲイザー
function c19204398.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c19204398.val)
	c:RegisterEffect(e1)
end
function c19204398.val(e,c)
	return Duel.GetMatchingGroupCount(Card.IsAttribute,c:GetControler(),0,LOCATION_GRAVE,nil,ATTRIBUTE_LIGHT)*200
end
