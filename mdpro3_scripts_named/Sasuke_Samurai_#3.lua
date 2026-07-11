--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Sasuke Samurai #3  (ID: 77379481)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 3
-- ATK 1000 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card inflicts Battle Damage to your opponent's Life Points, your opponent draws cards
-- until their hand has 7 cards.
--[[ __CARD_HEADER_END__ ]]

--大盤振舞侍
function c77379481.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(77379481,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c77379481.condition)
	e1:SetTarget(c77379481.target)
	e1:SetOperation(c77379481.operation)
	c:RegisterEffect(e1)
end
function c77379481.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c77379481.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	local ht=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	if ht<7 then
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,7-ht)
	end
end
function c77379481.operation(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ht=Duel.GetFieldGroupCount(p,LOCATION_HAND,0)
	if ht<7 then
		Duel.Draw(p,7-ht,REASON_EFFECT)
	end
end
