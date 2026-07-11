--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Panther Warrior  (ID: 42035044)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Level: 4
-- ATK 2000 | DEF 1600
-- Setcode: 0x66
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card cannot declare an attack unless you Tribute 1 monster.
--[[ __CARD_HEADER_END__ ]]

--漆黒の豹戦士パンサーウォリアー
function c42035044.initial_effect(c)
	--attack cost
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ATTACK_COST)
	e1:SetCost(c42035044.atcost)
	e1:SetOperation(c42035044.atop)
	c:RegisterEffect(e1)
end
function c42035044.atcost(e,c,tp)
	return Duel.CheckReleaseGroupEx(tp,nil,1,REASON_ACTION,false,e:GetHandler())
end
function c42035044.atop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectReleaseGroupEx(tp,nil,1,1,REASON_ACTION,false,e:GetHandler())
	Duel.Release(g,REASON_ACTION)
end
