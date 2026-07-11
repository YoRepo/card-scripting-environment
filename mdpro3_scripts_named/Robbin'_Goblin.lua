--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Robbin' Goblin  (ID: 88279736)
-- Type: Trap / Continuous
-- Setcode: 0xac
-- Scope: OCG / TCG
--
-- Effect Text:
-- Each time a monster you control inflicts Battle Damage to your opponent, your opponent discards 1
-- random card.
--[[ __CARD_HEADER_END__ ]]

--追い剥ぎゴブリン
function c88279736.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--handes
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(88279736,0))
	e2:SetCategory(CATEGORY_HANDES_OPPO)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCondition(c88279736.condition)
	e2:SetTarget(c88279736.target)
	e2:SetOperation(c88279736.operation)
	c:RegisterEffect(e2)
end
function c88279736.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and eg:GetFirst():GetControler()==tp and e:GetHandler():IsStatus(STATUS_EFFECT_ENABLED)
end
function c88279736.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_HANDES_OPPO,nil,0,1-tp,1)
end
function c88279736.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(ep,LOCATION_HAND,0)
	local sg=g:RandomSelect(ep,1)
	Duel.SendtoGrave(sg,REASON_DISCARD+REASON_EFFECT)
end
