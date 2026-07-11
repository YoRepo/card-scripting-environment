--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Atomic Firefly  (ID: 87340664)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Insect
-- Level: 1
-- ATK 100 | DEF 200
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this face-up card on the field attacks or is attacked and it is destroyed as a result of
-- battle, the player who destroyed it takes 1000 points of damage.
--[[ __CARD_HEADER_END__ ]]

--原子ホタル
function c87340664.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(87340664,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c87340664.condition)
	e1:SetTarget(c87340664.target)
	e1:SetOperation(c87340664.operation)
	c:RegisterEffect(e1)
end
function c87340664.condition(e,tp,eg,ep,ev,re,r,rp)
	e:SetLabel(e:GetHandler():GetReasonPlayer())
	return e:GetHandler():IsReason(REASON_BATTLE) and e:GetHandler():IsPreviousPosition(POS_FACEUP)
end
function c87340664.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(e:GetLabel())
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,e:GetLabel(),1000)
end
function c87340664.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
