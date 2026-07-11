--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Memory Crush King  (ID: 75675029)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 5
-- ATK 2000 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card inflicts Battle Damage to your opponent by a direct attack, remove from play all
-- Synchro Monsters in your opponent's Graveyard, and inflict 1000 damage to your opponent for each
-- monster removed.
--[[ __CARD_HEADER_END__ ]]

--記憶破壊王
function c75675029.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75675029,0))
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c75675029.condition)
	e1:SetTarget(c75675029.target)
	e1:SetOperation(c75675029.operation)
	c:RegisterEffect(e1)
end
function c75675029.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.GetAttackTarget()==nil
end
function c75675029.filter(c)
	return c:IsType(TYPE_SYNCHRO) and c:IsAbleToRemove()
end
function c75675029.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c75675029.filter,tp,0,LOCATION_GRAVE,nil)
	if g:GetCount()~=0 then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetCount()*1000)
	end
end
function c75675029.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c75675029.filter,tp,0,LOCATION_GRAVE,nil)
	local ct=Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	if ct~=0 then
		Duel.Damage(1-tp,ct*1000,REASON_EFFECT)
	end
end
